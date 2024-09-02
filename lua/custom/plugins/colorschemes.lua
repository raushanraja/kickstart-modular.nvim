return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    name = 'github',
    priority = 1000,
  },
  {
    'projekt0n/caret.nvim',
    lazy = false,
    name = 'caret',
    priority = 1000,
  },
  {
    'savq/melange-nvim',
    lazy = false,
    name = 'melange',
    priority = 1000,
  },
  {
    'Shatur/neovim-ayu',
    lazy = false,
    name = 'ayu',
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    name = 'gruvbox',
    priority = 1000,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'rose-pine/neovim',
    lazy = false,
    name = 'rose-pine',
    priority = 1000,
  },

  {
    'arcticicestudio/nord-vim',
    lazy = false,
    name = 'nord',
    priority = 1000,
  },

  {
    'rmehri01/onenord.nvim',
    lazy = false,
    name = 'onenord',
    priority = 1000,
  },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    name = 'zenbones',
    priority = 1000,
  },
  {
    'frenzyexists/aquarium-vim',
    lazy = false,
    name = 'aquarium',
    priority = 1000,
  },
  {
    'navarasu/onedark.nvim',
    lazy = false,
    name = 'onedark',
    priority = 1000,
    opts = {
      style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      -- toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      -- toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
    },
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    opts = {
      style = 'dark', -- dark, light, auto
      transparent = false, -- enable this to hide the background
      italic = true, -- enable italic
      guicolors = true, -- enable 24-bit RGB colors
    },
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
      }
      require('bamboo').load()
    end,
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.sonokai_enable_italic = true
      -- vim.cmd.colorscheme 'sonokai'
    end,
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function() end,
  },
}
