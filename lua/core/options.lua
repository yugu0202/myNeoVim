local opt = vim.opt

opt.termguicolors = true
opt.shell = 'powershell.exe'
opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
opt.shellxquote = ''
opt.tabstop = 4
opt.shiftwidth = 4
opt.updatetime = 500
opt.timeout = true
opt.timeoutlen = 300
opt.number = true

vim.g.sqlite_clib_path = 'C://Data/sqlite/sqlite3.dll'
