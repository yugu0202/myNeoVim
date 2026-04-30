local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function()
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'copilot' },
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'treesitter' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'emoji' },
		{ name = 'calc' },
		{ name = 'mocword' },
		{
			name = 'spell',
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
		},
	}),
	formatting = {
		format = function(entry, item)
			local color_item = require('nvim-highlight-colors').format(entry, { kind = item.kind })
			item = lspkind.cmp_format({
				maxwidth = 50,
				mode = 'symbol_text',
				symbol_map = { Copilot = '' },
				menu = {
					copilot = '[Copilot]',
					nvim_lsp = '[LSP]',
					buffer = '[Buffer]',
					path = '[Path]',
					treesitter = '[TS]',
					nvim_lua = '[Lua]',
					emoji = '[Emoji]',
					calc = '[Calc]',
					spell = '[Spell]',
					mocword = '[Word]',
				},
			})(entry, item)
			if color_item.abbr_hl_group then
				item.kind_hl_group = color_item.abbr_hl_group
				item.kind = color_item.abbr
			end
			return item
		end,
	},
	experimental = {
		ghost_text = true,
	},
})
