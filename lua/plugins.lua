local add = require('jetpack.packer').add

add({
	{ 'tani/vim-jetpack', opt = 1 }, -- bootstrap
	'vim-jp/vimdoc-ja',
	'nvim-lua/plenary.nvim',
	'BurntSushi/ripgrep',
	'kkharji/sqlite.lua',
	{
		'stevearc/oil.nvim',
		cmd = 'Oil',
		config = function()
			require('config.oil')
		end,
	},
	'nvim-tree/nvim-web-devicons',
	{
		'EdenEast/nightfox.nvim',
		run = ':NightfoxCompile',
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
		config = function()
			require('bufferline').setup({})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		event = 'VimEnter',
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
	'onsails/lspkind.nvim',
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('config.lsp')
		end,
	},
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	{
		'hrsh7th/nvim-cmp',
		config = function()
			require('config.cmp')
		end,
	},
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-emoji',
	'hrsh7th/cmp-calc',
	'f3fora/cmp-spell',
	'yutkat/cmp-mocword',
	'ray-x/cmp-treesitter',
	{
		'github/copilot.vim',
		event = 'InsertEnter',
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		cmd = 'Telescope',
		config = function()
			require('config.telescope')
		end,
	},
	'nvim-telescope/telescope-frecency.nvim',
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
})
