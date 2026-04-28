require('nightfox').setup({
	options = {
		module_default = false,
		modules = {
			cmp = true,
			fidget = true,
			indent_blankline = true,
			native_lsp = true,
			telescope = true,
			treesitter = true,
			whichkey = true,
		},
	},
})

vim.cmd('colorscheme nordfox')
