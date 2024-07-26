-- Treesitter
local opts = require 'custom.opts.treesitter'

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = vim.fn.argc(-1) == 0,
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  config = function()
    require('nvim-treesitter.configs').setup(opts)
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
