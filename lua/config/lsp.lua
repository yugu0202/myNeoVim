require('mason').setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

vim.lsp.config('*', {
	capabilities = capabilities,
})

require('mason-lspconfig').setup({})

vim.diagnostic.config({
	virtual_text = false,
})
