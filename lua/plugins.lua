require('lazy').setup({
	'vim-jp/vimdoc-ja',
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'nvim-tree/nvim-web-devicons',
	{
		'stevearc/oil.nvim',
		cmd = 'Oil',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('config.oil')
		end,
	},
	{
		'EdenEast/nightfox.nvim',
		build = ':NightfoxCompile',
		lazy = false,
		priority = 1000,
		config = function()
			require('config.ui')
		end,
	},
	{
		'norcalli/nvim-colorizer.lua',
		event = 'BufReadPost',
		config = function()
			require('colorizer').setup({})
		end,
	},
	{
		'akinsho/bufferline.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('bufferline').setup({})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('lualine').setup({
				options = {
					theme = 'nord',
					globalstatus = true,
				},
			})
		end,
	},
	{
		'j-hui/fidget.nvim',
		event = 'LspAttach',
		config = function()
			require('fidget').setup({})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'BufReadPost',
		config = function()
			require('nvim-treesitter.configs').setup({
				highlight = { enable = false },
			})
		end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufReadPost',
		config = function()
			require('ibl').setup({})
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/cmp-nvim-lsp',
		},
		config = function()
			require('config.lsp')
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'onsails/lspkind.nvim',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-emoji',
			'hrsh7th/cmp-calc',
			'f3fora/cmp-spell',
			'yutkat/cmp-mocword',
			'ray-x/cmp-treesitter',
		},
		config = function()
			require('config.cmp')
		end,
	},
	{
		'github/copilot.vim',
		event = 'InsertEnter',
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		cmd = 'Telescope',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'kkharji/sqlite.lua',
			'nvim-telescope/telescope-frecency.nvim',
		},
		config = function()
			require('config.telescope')
		end,
	},
	{
		'voldikss/vim-floaterm',
		cmd = 'FloatermToggle',
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = function()
			require('nvim-autopairs').setup({})
		end,
	},
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = function()
			require('which-key').setup({})
		end,
	},
}, {
	install = {
		colorscheme = { 'nordfox' },
	},
})
