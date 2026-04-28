local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 外部ツール（Copilot CLI 等）によるファイル変更を自動反映する
local autoread_group = augroup('AutoRead', { clear = true })

autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
	group = autoread_group,
	pattern = '*',
	callback = function()
		if vim.fn.mode() ~= 'c' then
			vim.cmd('checktime')
		end
	end,
})
