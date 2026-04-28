require('telescope').setup({
	defaults = {
		path_display = { 'smart', 'truncate' },
		layout_config = { width = 0.95 },
	},
})

require('telescope').load_extension('frecency')
