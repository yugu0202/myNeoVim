local add = require('jetpack.packer').add

add({
	{ 'tani/vim-jetpack', opt = 1 }, -- bootstrap
	'vim-jp/vimdoc-ja',
	'nvim-lua/plenary.nvim',
	'BurntSushi/ripgrep',
	'kkharji/sqlite.lua',
	{
		'stevearc/oil.nvim',
		config = function()
			require('config.oil')
		end,
	},
	'nvim-tree/nvim-web-devicons',
	'EdenEast/nightfox.nvim',
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup({})
		end,
	},
	{
		'akinsho/bufferline.nvim',
		config = function()
			require('bufferline').setup({})
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
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
		config = function()
			require('fidget').setup({})
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				highlight = { enable = false },
			})
		end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('ibl').setup({})
		end,
	},
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
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-emoji',
	'hrsh7th/cmp-calc',
	'f3fora/cmp-spell',
	'yutkat/cmp-mocword',
	'ray-x/cmp-treesitter',
	'github/copilot.vim',
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
	},
	'nvim-telescope/telescope-frecency.nvim',
	'voldikss/vim-floaterm',
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup({})
		end,
	},
	{
		'folke/which-key.nvim',
		config = function()
			require('which-key').setup({})
		end,
	},
})
