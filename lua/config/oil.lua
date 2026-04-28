require('oil').setup({
	columns = { 'icon' },
	default_file_explorer = true,
	float = {
		padding = 2,
		max_width = 0.8,
		max_height = 0.8,
	},
	keymaps = {
		['<C-h>'] = false,
		['q']     = { 'actions.close',                                    desc = '閉じる' },
		['<CR>']  = { 'actions.select',                                   desc = 'ファイル/ディレクトリを開く' },
		['<C-v>'] = { 'actions.select', opts = { vertical   = true },     desc = '縦分割で開く' },
		['<C-s>'] = { 'actions.select', opts = { horizontal = true },     desc = '横分割で開く' },
		['<C-t>'] = { 'actions.select', opts = { tab        = true },     desc = 'タブで開く' },
		['<C-p>'] = { 'actions.preview',                                  desc = 'プレビュー' },
		['<C-c>'] = { 'actions.close',                                    desc = '変更を破棄して閉じる' },
		['<C-l>'] = { 'actions.refresh',                                  desc = '更新' },
		['-']     = { 'actions.parent',                                   desc = '親ディレクトリへ' },
		['_']     = { 'actions.open_cwd',                                 desc = 'CWD で開く' },
		['`']     = { 'actions.cd',                                       desc = 'CWD に設定' },
		['~']     = { 'actions.cd',      opts = { scope = 'tab' },        desc = 'タブの CWD に設定' },
		['gs']    = { 'actions.change_sort',                              desc = 'ソート変更' },
		['gx']    = { 'actions.open_external',                            desc = '外部アプリで開く' },
		['g.']    = { 'actions.toggle_hidden',                            desc = '隠しファイルをトグル' },
		['g\\']   = { 'actions.toggle_trash',                             desc = 'ゴミ箱モードをトグル' },
	},
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = 'yes:2',
	},
})
