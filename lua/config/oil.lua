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
		['q'] = 'actions.close',
		['<C-v>'] = { 'actions.select', opts = { vertical = true } },
		['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
		['<C-t>'] = { 'actions.select', opts = { tab = true } },
	},
	view_options = {
		show_hidden = true,
	},
	win_options = {
		signcolumn = 'yes:2',
	},
})
