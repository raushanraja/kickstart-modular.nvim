-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.showmode = false
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Configure how new splits should be opened
vim.opt.splitright = false
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.backupdir = os.getenv 'HOME' .. '/.vim/backupdir'
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'

-- search case pattern option
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.title = true

-- vim.opt.foldmethod = "indent"
vim.o.statuscolumn = '%C%s%r  '

if vim.fn.has 'title' then
  -- local current_file = vim.fn.expand('%:p:h')                     -- Get the full path of the parent directory
  -- local parent_directory = vim.fn.fnamemodify(current_file, ':t') -- Get the last part of the path
  -- local file_name = '%' .. '{expand(\'%:p:h:t\')}/%t'                          -- Get the file name
  -- vim.o.titlestring = parent_directory .. ' - ' .. file_name      -- Set the title
  --
  -- vim.o.titlestring = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t') .. ' - %' .. '{expand(\'%:p:h:t\')}/%t'
  --   Same thing but the other way around, (file name - parent directory)
  vim.o.titlestring = '%' .. "{expand('%:p:h:t')}/%t - (" .. vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':t') .. ') - NVIM'
end

vim.g.zenbones = { lightness = 'dim', darkness = 'stark' }

vim.g.aqua_transparency = 1

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Add custom filetypes with their extensions
vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}
