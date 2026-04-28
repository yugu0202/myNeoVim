local map = vim.keymap.set
local opts = { silent = true }

map('n', '==', '<cmd>Oil --float<CR>', opts)

map('n', '<Tab>', '<cmd>bnext<CR>', opts)
map('n', '<S-Tab>', '<cmd>bprevious<CR>', opts)

map('n', 'K', vim.lsp.buf.hover, opts)
map('n', 'gf', vim.lsp.buf.format, opts)
map('n', 'gr', vim.lsp.buf.references, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', 'gD', vim.lsp.buf.declaration, opts)
map('n', 'gi', vim.lsp.buf.implementation, opts)
map('n', 'gt', vim.lsp.buf.type_definition, opts)
map('n', 'gn', vim.lsp.buf.rename, opts)
map('n', 'ga', vim.lsp.buf.code_action, opts)
map('n', 'ge', vim.diagnostic.open_float, opts)
map('n', 'g]', vim.diagnostic.goto_next, opts)
map('n', 'g[', vim.diagnostic.goto_prev, opts)

map('n', '<leader>ff', '<cmd>Telescope git_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
map('n', '<leader>fy', '<cmd>Telescope frecency<CR>', opts)

map('n', ']h', '<cmd>Gitsigns next_hunk<CR>', opts)
map('n', '[h', '<cmd>Gitsigns prev_hunk<CR>', opts)
map('n', '<leader>ghp', '<cmd>Gitsigns preview_hunk_inline<CR>', opts)
map('n', '<leader>ghs', '<cmd>Gitsigns stage_hunk<CR>', opts)
map('n', '<leader>ghr', '<cmd>Gitsigns reset_hunk<CR>', opts)
map('n', '<leader>ghb', '<cmd>Gitsigns blame_line<CR>', opts)
map('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', opts)
map('n', '<leader>gq', '<cmd>DiffviewClose<CR>', opts)
map('n', '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', opts)

map('n', '<leader>ft', '<cmd>FloatermToggle<CR>', opts)
map('t', '<leader>ft', '<cmd>FloatermToggle<CR>', opts)
