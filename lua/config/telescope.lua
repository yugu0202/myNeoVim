require('telescope').setup({
	defaults = {
		preview = {
			treesitter = false,
		},
	},
})

require('telescope').load_extension('frecency')
