require('blink.cmp').setup({
	keymap = {
		preset = 'none',
		['<Tab>'] = { 'select_next', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<CR>'] = { 'accept', 'fallback' },
		['<C-e>'] = { 'hide' },
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-n>'] = { 'select_next', 'fallback' },
		['<C-p>'] = { 'select_prev', 'fallback' },
	},
	sources = {
		default = { 'copilot', 'lsp', 'buffer', 'path' },
		providers = {
			copilot = {
				name = 'Copilot',
				module = 'blink-copilot',
				score_offset = 100,
				async = true,
			},
		},
	},
	completion = {
		documentation = { auto_show = true },
		ghost_text = { enabled = false },
		menu = {
			draw = {
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind_icon', 'kind', gap = 1 },
					{ 'source_name' },
				},
			},
		},
	},
	appearance = {
		nerd_font_variant = 'mono',
	},
})
