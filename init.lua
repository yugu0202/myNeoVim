local config_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')

vim.opt.runtimepath:prepend(config_root)
pcall(vim.loader.enable)
vim.cmd('packadd vim-jetpack')

require('core.options')
require('plugins')
require('core.keymaps')
