require('mason').setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, 'blink.cmp')
if ok then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config('*', {
	capabilities = capabilities,
})

require('mason-lspconfig').setup({})

vim.diagnostic.config({
	virtual_text = false,
})
