require('mason').setup({})

vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	),
})

require('mason-lspconfig').setup({})

vim.diagnostic.config({
	virtual_text = false,
})
