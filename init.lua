local config_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

vim.opt.runtimepath:prepend(config_root)
pcall(vim.loader.enable)

if not uv.fs_stat(lazypath) then
	local output = vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error('lazy.nvim bootstrap failed:\n' .. output)
	end
end

vim.opt.runtimepath:prepend(lazypath)

require('core.options')
require('core.autocmds')
require('plugins')
require('core.keymaps')
