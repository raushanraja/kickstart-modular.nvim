return {
  'akinsho/flutter-tools.nvim',
  ft = { 'dart' },
  lazy = true,
  event = 'BufReadPre',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = true,
}
