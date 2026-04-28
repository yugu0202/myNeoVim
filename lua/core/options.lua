local opt = vim.opt
local shell = vim.fn.exepath('pwsh')

if shell == '' then
	shell = 'powershell.exe'
end

opt.termguicolors = true
opt.shell = shell
opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
opt.shellxquote = ''
vim.g.floaterm_shell = shell
opt.tabstop = 4
opt.shiftwidth = 4
opt.updatetime = 500
opt.timeout = true
opt.timeoutlen = 300
opt.number = true
opt.autoread = true

vim.g.sqlite_clib_path = 'C://Data/sqlite/sqlite3.dll'
