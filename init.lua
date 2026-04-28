local config_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h')

vim.opt.runtimepath:prepend(config_root)
vim.cmd('packadd vim-jetpack')

require('core.options')
require('plugins')
require('config.ui')
require('config.lsp')
require('config.cmp')
require('config.telescope')
require('core.keymaps')
