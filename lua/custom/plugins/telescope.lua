-- plugins/telescope.lua:
local dependencies = {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- `build` is used to run some command when the plugin is installed/updated.
    -- This is only run then, not every time Neovim starts up.
    build = 'make',
    -- `cond` is a condition used to determine whether this plugin should be
    -- installed and loaded.
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' }, -- Useful for getting pretty icons, but requires a Nerd Font.
}

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.7',
  event = 'VimEnter',
  dependencies = dependencies,
  config = function()
    require('telescope').setup {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end,
}
