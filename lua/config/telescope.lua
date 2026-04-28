require('telescope').setup({
	defaults = {
		path_display = { 'smart' },
	},
})

require('telescope').load_extension('frecency')
