local map = vim.keymap.set

map('n', '==', '<cmd>Oil --float<CR>', { silent = true, desc = 'ファイルツリーを開く' })

map('n', '<Tab>', '<cmd>bnext<CR>', { silent = true, desc = '次のバッファ' })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { silent = true, desc = '前のバッファ' })

-- LSP
map('n', 'K', vim.lsp.buf.hover, { silent = true, desc = 'ホバー情報' })
map('n', 'gf', vim.lsp.buf.format, { silent = true, desc = 'フォーマット' })
map('n', 'gr', vim.lsp.buf.references, { silent = true, desc = '参照一覧' })
map('n', 'gd', vim.lsp.buf.definition, { silent = true, desc = '定義へ移動' })
map('n', 'gD', vim.lsp.buf.declaration, { silent = true, desc = '宣言へ移動' })
map('n', 'gi', vim.lsp.buf.implementation, { silent = true, desc = '実装へ移動' })
map('n', 'gt', vim.lsp.buf.type_definition, { silent = true, desc = '型定義へ移動' })
map('n', 'gn', vim.lsp.buf.rename, { silent = true, desc = 'リネーム' })
map('n', 'ga', vim.lsp.buf.code_action, { silent = true, desc = 'コードアクション' })
map('n', 'ge', vim.diagnostic.open_float, { silent = true, desc = '診断詳細を表示' })
map('n', 'g]', vim.diagnostic.goto_next, { silent = true, desc = '次の診断へ' })
map('n', 'g[', vim.diagnostic.goto_prev, { silent = true, desc = '前の診断へ' })

-- Find（Telescope）
map('n', '<leader>ff', '<cmd>Telescope git_files<CR>', { silent = true, desc = 'Git ファイル検索' })
map('n', '<leader>fF', '<cmd>Telescope find_files<CR>', { silent = true, desc = 'ファイル検索' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { silent = true, desc = 'テキスト検索' })
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { silent = true, desc = 'バッファ一覧' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { silent = true, desc = 'ヘルプ検索' })
map('n', '<leader>fy', '<cmd>Telescope frecency<CR>', { silent = true, desc = '最近のファイル' })
map('n', '<leader>ft', '<cmd>FloatermToggle<CR>', { silent = true, desc = 'ターミナル' })
map('t', '<leader>ft', '<cmd>FloatermToggle<CR>', { silent = true, desc = 'ターミナルを閉じる' })

-- Git hunk（Gitsigns）
map('n', ']h', '<cmd>Gitsigns next_hunk<CR>', { silent = true, desc = '次の変更へ' })
map('n', '[h', '<cmd>Gitsigns prev_hunk<CR>', { silent = true, desc = '前の変更へ' })
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk_inline<CR>', { silent = true, desc = '変更をプレビュー' })
map('n', '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>', { silent = true, desc = 'ハンクをステージ' })
map('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', { silent = true, desc = 'ハンクをリセット' })
map('n', '<leader>ghb', '<cmd>Gitsigns blame_line<CR>', { silent = true, desc = '行の blame' })

-- Git（Diffview）
map('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { silent = true, desc = 'Diffview を開く' })
map('n', '<leader>gD', '<cmd>DiffviewOpen HEAD~1<CR>', { silent = true, desc = '直前のコミットと比較' })
map('n', '<leader>gq', '<cmd>DiffviewClose<CR>', { silent = true, desc = 'Diffview を閉じる' })
map('n', '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', { silent = true, desc = 'ファイル履歴' })
map('n', '<leader>gF', '<cmd>DiffviewFileHistory<CR>', { silent = true, desc = 'リポジトリ全体の履歴' })
