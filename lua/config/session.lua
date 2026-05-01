require('auto-session').setup({
	auto_restore = true,
	auto_save = true,
	suppressed_dirs = { vim.fn.expand('~'), vim.fn.expand('~/Downloads'), '/' },
	session_lens = {
		load_on_setup = true,
		previewer = 'summary',
	},
})
