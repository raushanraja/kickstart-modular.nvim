-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.g.mapleader = ' '
vim.g.astro_typescript = 'enable'
vim.g.astro_stylus = 'enable'

local opts = {
  noremap = true,
  silent = true,
}
local nonopts = {
  noremap = true,
  silent = false,
}
local keymap = vim.api.nvim_set_keymap
local keymapset = vim.keymap.set

keymap('', 'j', 'h', opts)
keymap('', ';', 'l', opts)
keymap('', 'k', 'k', opts)
keymap('', 'l', 'j', opts)

-- keymap("n", "<leader>pv", ":Ex<cr>", opts)
keymap('n', '<C-j>', '<C-w>h', opts)
keymap('n', '<C-;', '<C-w>l', opts)
keymap('n', '<C-l>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w><C-w>', opts)
keymap('n', '<leader>u', ':UndotreeToggle<cr>', opts)

-- SPLIT WINDOWS
keymap('n', '<leader>v', '<C-w>v', opts)
keymap('n', '<leader>h', '<C-w>s', opts)

keymap('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
keymap('i', 'jk', '<esc>', opts)

-- Save FIle
keymap('n', '<leader>w', ':w<cr>', opts)

-- Move Selected line up/down
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)
keymap('v', 'L', ":m '>+1<CR>gv=gv", opts)

-- Move next line to the line where cursor is present
keymap('n', 'J', 'mzJ`z', opts)

-- Scrolling UP - DOWN
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Keeping the search centered
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Paste without replacing the current paste buffer
keymap('x', '<leader>p', [["_dP]], nonopts)

-- Copy to systemclipboard vs nvim clipboard only
keymap('v', '<leader>y', [["+y]], nonopts)
keymap('n', '<leader>y', [["+y]], nonopts)
keymap('n', '<leader>Y', [["+Y]], nonopts)

keymap('n', '<leader>ps', [["+p]], nonopts)
keymap('v', '<leader>ps', [["+p]], nonopts)

-- Set Captial Q no operation, Format using Space-j
keymap('n', 'Q', '<nop>', nonopts)
-- keymap('n', '<leader>j', ':Format<cr>', nonopts)

-- NVIMTreeToggle
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
-- Lazygit Toggle
keymap('n', '<leader>gg', ':LazyGit<cr>', opts)

-- Comment Plugin
keymap('n', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

-- DAP
-- keymap("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", opts)
-- keymap("n", "<leader>dpr", "<cmd>lua require('dap-python').test_method()<cr>", opts)

-- ToggleTerm
keymap('n', '<m-t>', "<cmd> lua TTerm(101, 'horizontal')<cr>", nonopts)
keymap('t', '<m-t>', "<cmd> lua TTerm(101, 'horizontal')<cr>", nonopts)
-- keymap("n", "<m-h>", "<cmd> lua TTerm(102, 'vertical',70)<cr>", nonopts)
-- keymap("t", "<m-h>", "<cmd> lua TTerm(102, 'vertical',70)<cr>", nonopts)
keymap('n', 'tt', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)
keymap('n', '<c-t>', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)
keymap('t', '<c-t>', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)

-- Swithc Buffers
keymap('n', '<leader>bb', '<cmd> bnext<cr>', nonopts)
keymap('n', '<tab>', '<C-w><C-w>', opts)
keymap('n', '<m-q>', '<cmd> lua ExitPrompt()<cr>', opts)

-- Diffview
keymap('n', '<leader>df', '<cmd> DiffviewFileHistory %<cr>', nonopts)

-- TroubleNvim
keymap('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', nonopts)
keymap('n', '<leader>td', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', nonopts)

-- Telescope
keymap('n', '<leader>tp', "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", nonopts)

-- Gitsigns
keymap('n', '<leader>hp', "<cmd>lua require('gitsigns').preview_hunk()<cr>", nonopts)
keymap('n', '<leader>hr', "<cmd>lua require('gitsigns').reset_hunk()<cr>", nonopts)
keymap('n', '<leader>hn', "<cmd>lua require('gitsigns').next_hunk()<cr>", nonopts)

-- CopilotChat (alt-c), rather than leader-c
keymapset('n', '<A-c>', function()
  local input = vim.fn.input 'CC: '
  if input ~= '' then
    vim.cmd('CopilotChat ' .. input)
  end
end, nonopts)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
--
--
function TTerm(count, direction, size)
  local cmd = nil
  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new { cmd = cmd, count = count, direction = direction, size = size }
  term:toggle(size, direction)
end

function _G.set_terminal_keymaps()
  local o = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], o)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w><C-w>]], o)
end

vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

-- ToggleTerm
keymap('n', '<m-t>', "<cmd> lua TTerm(101, 'horizontal')<cr>", nonopts)
keymap('t', '<m-t>', "<cmd> lua TTerm(101, 'horizontal')<cr>", nonopts)
-- keymap("n", "<m-h>", "<cmd> lua TTerm(102, 'vertical',70)<cr>", nonopts)
-- keymap("t", "<m-h>", "<cmd> lua TTerm(102, 'vertical',70)<cr>", nonopts)
keymap('n', 'tt', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)
keymap('n', '<c-t>', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)
keymap('t', '<c-t>', "<cmd> lua TTerm(103, 'float')<cr>", nonopts)

-- Set up an autocommand to modify the backup extension on buffer write
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local bex = '@' .. os.date '%Y-%m-%d.%H:%M'
    vim.opt.backupext = bex
  end,
})
