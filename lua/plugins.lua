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
		'brenoprata10/nvim-highlight-colors',
		event = 'BufReadPost',
		config = function()
			require('nvim-highlight-colors').setup({})
		end,
	},
	{
		'TaDaa/vimade',
		event = 'VimEnter',
		config = function()
			require('vimade').setup({
				recipe = { 'default', { animate = true } },
				ncmode = 'windows',
				fadelevel = 0.4,
			})
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
		build = ':TSUpdate',
		lazy = false,
		config = function()
			require('nvim-treesitter').setup({})
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
		},
		config = function()
			require('config.lsp')
		end,
	},
	{
		'saghen/blink.cmp',
		version = '*',
		event = { 'InsertEnter', 'CmdlineEnter' },
		dependencies = {
			'fang2hou/blink-copilot',
		},
		config = function()
			require('config.blink')
		end,
	},
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
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
		'lewis6991/gitsigns.nvim',
		event = 'BufReadPost',
		config = function()
			require('config.git')
		end,
	},
	{
		'esmuellert/codediff.nvim',
		cmd = 'CodeDiff',
		opts = {
			diff = {
				layout = 'side-by-side',
				jump_to_first_change = true,
				cycle_next_hunk = true,
			},
			explorer = {
				position = 'left',
				width = 35,
			},
		},
		config = function(_, opts)
			require('codediff').setup(opts)
			vim.api.nvim_create_autocmd('User', {
				pattern = 'CodeDiffOpen',
				callback = function()
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
						vim.wo[win].wrap = true
					end
				end,
			})
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
			require('config.which_key')
		end,
	},
}, {
	install = {
		colorscheme = { 'nordfox' },
	},
})
