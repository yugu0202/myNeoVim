-- Packer.nvim v2
vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
	{'tani/vim-jetpack', opt = 1}, -- bootstrap
	'vim-jp/vimdoc-ja',
	'nvim-lua/plenary.nvim',
	'BurntSushi/ripgrep',
	'kkharji/sqlite.lua',
	'lambdalisue/nerdfont.vim',
	'lambdalisue/fern.vim',
	'lambdalisue/fern-renderer-nerdfont.vim',
	'lambdalisue/fern-git-status.vim',
	'lambdalisue/glyph-palette.vim',
	'kyazdani42/nvim-web-devicons',
	'EdenEast/nightfox.nvim',
	'norcalli/nvim-colorizer.lua',
	'akinsho/bufferline.nvim',
	'nvim-lualine/lualine.nvim',
	'j-hui/fidget.nvim',
	{'nvim-treesitter/nvim-treesitter',
	config = function()
			require'nvim-treesitter.configs'.setup {
				highlight = { enable = false }
			}
		end
	},
	'lukas-reineke/indent-blankline.nvim',
	'onsails/lspkind.nvim',
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-nvim-lsp-document-symbol',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-emoji',
	'hrsh7th/cmp-calc',
	'f3fora/cmp-spell',
	'yutkat/cmp-mocword',
	'ray-x/cmp-treesitter',
	{'nvim-telescope/telescope.nvim',
	tag = '0.1.0'
	},
	'nvim-telescope/telescope-frecency.nvim',
	'sidebar-nvim/sidebar.nvim',
	'voldikss/vim-floaterm',
	'windwp/nvim-autopairs',
}

vim.api.nvim_set_var('fern#renderer','nerdfont')
vim.api.nvim_set_var('sqlite_clib_path','C://Data/sqlite/sqlite3.dll')

vim.api.nvim_create_augroup('my-glyph-palette', {})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'fern',
	group = 'my-glyph-palette',
	command = 'call glyph_palette#apply()'
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = {'nerdtree','startify'},
	group = 'my-glyph-palette',
	command = 'call glyph_palette#apply()'
})

vim.api.nvim_set_keymap('n', '==',  '<cmd>Fern . -reveal=% -toggle -drawer<CR>', {})

require('colorizer').setup{}
require('nvim-autopairs').setup{}

require('lualine').setup{
	options = {
		theme = 'nord',
		globalstatus = true
	}
}

require('bufferline').setup{}

require('indent_blankline').setup{
	show_current_context = true,
	show_current_context_start = true,
}

-- normal mode buffer cycle
vim.api.nvim_set_keymap('n', '<TAB>',  '<cmd>BufferLineCycleNext<CR>', {})
vim.api.nvim_set_keymap('n', '<S-TAB>',  '<cmd>BufferLineCyclePrev<CR>', {})

vim.cmd('colorscheme nordfox')
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

require('sidebar-nvim').setup({
	sections = { 'datetime', 'git', 'diagnostics', 'containers', 'files', 'symbols' },
	symbols = { icon = 'ƒ' },
	containers = {
		icon = '',
		use_podman = false,
		attach_shell = '/bin/bash',
		show_all = true,
		interval = 5000,
	},
	files = {
		icon = '',
		show_hidden = true,
		ignore_paths = {'%.git$'}
	},
})


-- LSP server management
require('mason').setup{}
require('mason-lspconfig').setup_handlers({ function(server)
	local opt = {
	-- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    -- local opts = { noremap=true, silent=true }
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- 2. build-in LSP function
-- keyboard shortcut
vim.api.nvim_set_keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>',{})
vim.api.nvim_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>',{})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',{})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',{})
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>',{})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',{})
vim.api.nvim_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>',{})
vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>',{})
vim.api.nvim_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>',{})
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>',{})
vim.api.nvim_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>',{})
vim.api.nvim_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>',{})
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

local function on_cursor_hold()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })

require('fidget').setup{}

-- Set up nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<TAB>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-TAB>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_document_symbol' },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'treesitter' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'emoji' },
		{ name = 'calc' },
		{ name = 'mocword' },
		{ name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
		},
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
		})
	},
	experimental = {
		ghost_text = true,
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		-- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

vim.api.nvim_set_keymap('n', '<leader>ff', [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>fy', [[<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>fb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], {})
vim.api.nvim_set_keymap('n', '<leader>fh', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], {})

vim.api.nvim_set_keymap('n', '<leader>ft', [[<Cmd>FloatermToggle<CR>]], {})
vim.api.nvim_set_keymap('t', '<leader>ft', [[<Cmd>FloatermToggle<CR>]], {})

vim.o.number = true
