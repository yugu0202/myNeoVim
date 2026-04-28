local api = vim.api
local M = {}

local NS = api.nvim_create_namespace('gitsigns_wrap_preview')
local state = { bufnr = nil, active = false }

-- ── 1. 折り返しロジック ──────────────────────────────────────────────────────
-- text をウィンドウ幅 max_width で折り返す
-- 戻り値: wrapped_lines (string[]), col_map ({orig_byte_col -> {line_idx(0-based), col}})
local function wrap_line(text, max_width)
	if vim.fn.strdisplaywidth(text) <= max_width then
		return { text }, {}
	end

	local lines = {}
	local col_map = {}
	local current = ''
	local current_width = 0
	local orig_byte = 0
	local line_idx = 0

	local i = 1
	while i <= #text do
		local b = text:byte(i)
		local char_len = b < 0x80 and 1 or b < 0xE0 and 2 or b < 0xF0 and 3 or 4
		local char = text:sub(i, i + char_len - 1)
		local char_w = vim.fn.strdisplaywidth(char)

		if current_width + char_w > max_width then
			-- スペースで折り返せるか試みる
			local last_space = current:match('.*()%s')
			if last_space and last_space > 1 then
				local before = current:sub(1, last_space - 1)
				local after = current:sub(last_space + 1)
				table.insert(lines, before)
				line_idx = line_idx + 1
				current = after
				current_width = vim.fn.strdisplaywidth(after)
			else
				table.insert(lines, current)
				line_idx = line_idx + 1
				current = ''
				current_width = 0
			end
		end

		col_map[orig_byte] = { line_idx, #current }
		current = current .. char
		current_width = current_width + char_w
		orig_byte = orig_byte + char_len
		i = i + char_len
	end

	col_map[orig_byte] = { line_idx, #current }
	if current ~= '' then
		table.insert(lines, current)
	end

	return lines, col_map
end

-- ── 2. Word diff 計算 ────────────────────────────────────────────────────────
-- removed_lines / added_lines の文字レベル差分を vim.diff() で計算
-- 戻り値: { removed = {line_idx(0-based), sc, ec}[], added = {...}[] }
local function calc_word_diff(removed_lines, added_lines)
	if #removed_lines ~= #added_lines then
		return nil
	end

	local removed_regions = {}
	local added_regions = {}

	local function to_char_lines(s)
		return table.concat(vim.split(s, ''), '\n') .. '\n'
	end

	for i = 1, #removed_lines do
		local ok, indices = pcall(vim.diff, to_char_lines(removed_lines[i]), to_char_lines(added_lines[i]), {
			result_type = 'indices',
			algorithm = 'minimal',
		})
		if not ok then
			goto continue
		end
		for _, r in ipairs(indices) do
			local sa, ca, sb, cb = r[1], r[2], r[3], r[4]
			if ca > 0 then
				table.insert(removed_regions, { i - 1, sa - 1, sa - 1 + ca })
			end
			if cb > 0 then
				table.insert(added_regions, { i - 1, sb - 1, sb - 1 + cb })
			end
		end
		::continue::
	end

	return { removed = removed_regions, added = added_regions }
end

-- ── 3. 折り返し後の列位置リマップ ───────────────────────────────────────────
-- col_map を使って {orig_line_idx, sc, ec} を折り返し後の座標に変換
-- flat_base: 折り返し前の orig_line_idx のフラットインデックス上の先頭位置
local function remap_region(region, wrapped_lines, col_map)
	local orig_line_idx, sc, ec = region[1], region[2], region[3]
	local lines = wrapped_lines[orig_line_idx + 1]
	if not lines then
		return { region }
	end

	local result = {}
	local cum = 0
	local flat = 0

	-- flat_base を計算（orig_line_idx 以前の行の折り返し数の合計）
	for j = 1, orig_line_idx do
		flat = flat + #wrapped_lines[j]
	end

	for wi, wl in ipairs(lines) do
		local wl_bytes = #wl
		local line_sc = cum
		local line_ec = cum + wl_bytes
		-- このラップ行と [sc, ec] の交差を計算
		local inter_sc = math.max(sc, line_sc)
		local inter_ec = math.min(ec, line_ec)
		if inter_sc < inter_ec then
			table.insert(result, { flat + wi - 1, inter_sc - line_sc, inter_ec - line_sc })
		end
		cum = cum + wl_bytes
	end

	return result
end

-- ── 4. カーソル位置のハンク取得 ──────────────────────────────────────────────
local function get_cursor_hunk()
	local hunks = require('gitsigns').get_hunks()
	if not hunks then
		return nil
	end
	local lnum = api.nvim_win_get_cursor(0)[1]
	for _, hunk in ipairs(hunks) do
		local s = hunk.added.start
		local e = s + math.max(hunk.added.count - 1, 0)
		if lnum >= s and lnum <= e then
			return hunk
		end
		-- pure delete: added.count == 0, カーソルが直前の行にある
		if hunk.added.count == 0 and lnum == s then
			return hunk
		end
	end
	return nil
end

-- ── 5. virt_lines 構築 ───────────────────────────────────────────────────────
local function build_virt_lines(all_lines, regions, line_hl, region_hl, prefix)
	local virt_lines = {}

	-- flat_idx -> regions のマップを作成
	local by_line = {}
	for _, r in ipairs(regions) do
		local fi = r[1]
		by_line[fi] = by_line[fi] or {}
		table.insert(by_line[fi], r)
	end

	for fi, line in ipairs(all_lines) do
		local flat_idx = fi - 1
		local chunks = {}
		table.insert(chunks, { prefix, line_hl })

		local line_regions = by_line[flat_idx] or {}
		table.sort(line_regions, function(a, b)
			return a[2] < b[2]
		end)

		if #line_regions == 0 then
			table.insert(chunks, { line, line_hl })
		else
			local pos = 0
			for _, r in ipairs(line_regions) do
				local sc = math.min(r[2], #line)
				local ec = math.min(r[3], #line)
				if sc > pos then
					table.insert(chunks, { line:sub(pos + 1, sc), line_hl })
				end
				if ec > sc then
					table.insert(chunks, { line:sub(sc + 1, ec), region_hl })
				end
				pos = ec
			end
			if pos < #line then
				table.insert(chunks, { line:sub(pos + 1), line_hl })
			end
		end

		table.insert(virt_lines, chunks)
	end

	return virt_lines
end

-- ── クリア ──────────────────────────────────────────────────────────────────
local function clear_preview(bufnr)
	api.nvim_buf_clear_namespace(bufnr or state.bufnr or 0, NS, 0, -1)
	state.active = false
	state.bufnr = nil
end

local aug = api.nvim_create_augroup('GitsignsWrapPreview', { clear = true })

-- ── 6. メイン関数 ────────────────────────────────────────────────────────────
function M.preview_hunk_inline_wrapped()
	local bufnr = api.nvim_get_current_buf()

	-- 同じバッファで再実行したらトグルオフ
	if state.active and state.bufnr == bufnr then
		clear_preview(bufnr)
		return
	end

	clear_preview()

	local hunk = get_cursor_hunk()
	if not hunk then
		vim.notify('カーソル位置にハンクがありません', vim.log.levels.INFO)
		return
	end

	-- ウィンドウ幅の計算（サインカラム等を除く）
	local win_width = api.nvim_win_get_width(0)
	local text_off = vim.fn.getwininfo(vim.fn.win_getid())[1].textoff
	local max_width = win_width - text_off - 3 -- プレフィックス "- " / "+ " の2文字 + 余白

	local removed_lines = hunk.removed.lines or {}
	local added_lines = hunk.added.lines or {}

	-- word diff（change ハンクかつ50行以内のみ）
	local word_diff = nil
	if hunk.type == 'change' and #removed_lines <= 50 then
		word_diff = calc_word_diff(removed_lines, added_lines)
	end

	-- 削除行を折り返す
	local wrapped_removed = {}
	for i, line in ipairs(removed_lines) do
		wrapped_removed[i] = wrap_line(line, max_width)
	end

	-- 追加行を折り返す
	local wrapped_added = {}
	for i, line in ipairs(added_lines) do
		wrapped_added[i] = wrap_line(line, max_width)
	end

	-- フラットリストに展開
	local all_removed_lines = {}
	for _, wrapped in ipairs(wrapped_removed) do
		for _, wl in ipairs(wrapped) do
			table.insert(all_removed_lines, wl)
		end
	end

	local all_added_lines = {}
	for _, wrapped in ipairs(wrapped_added) do
		for _, wl in ipairs(wrapped) do
			table.insert(all_added_lines, wl)
		end
	end

	-- word diff のリージョンをリマップ
	local removed_regions = {}
	local added_regions = {}
	if word_diff then
		for _, region in ipairs(word_diff.removed) do
			vim.list_extend(removed_regions, remap_region(region, wrapped_removed, nil))
		end
		for _, region in ipairs(word_diff.added) do
			vim.list_extend(added_regions, remap_region(region, wrapped_added, nil))
		end
	end

	-- 削除行（赤 "-"）の virt_lines
	local del_virt = build_virt_lines(
		all_removed_lines,
		removed_regions,
		'GitSignsDeleteVirtLn',
		'GitSignsDeleteVirtLnInLine',
		'- '
	)

	-- 追加行（緑 "+"）の virt_lines
	local add_virt = build_virt_lines(
		all_added_lines,
		added_regions,
		'GitSignsAddPreview',
		'GitSignsAddInline',
		'+ '
	)

	-- 削除行 → 追加行の順に結合
	local virt_lines = {}
	vim.list_extend(virt_lines, del_virt)
	vim.list_extend(virt_lines, add_virt)

	if #virt_lines == 0 then
		vim.notify('表示するハンクがありません', vim.log.levels.INFO)
		return
	end

	-- ハンク先頭行の上に配置（0-based）
	local row = hunk.added.start - 1
	if hunk.added.count == 0 then
		row = hunk.removed.start
	end

	api.nvim_buf_set_extmark(bufnr, NS, row, 0, {
		virt_lines = virt_lines,
		virt_lines_above = true,
	})

	state.active = true
	state.bufnr = bufnr

	-- CursorMoved で自動クリア
	api.nvim_create_autocmd('CursorMoved', {
		group = aug,
		buffer = bufnr,
		once = true,
		callback = function()
			clear_preview(bufnr)
		end,
	})
end

return M
