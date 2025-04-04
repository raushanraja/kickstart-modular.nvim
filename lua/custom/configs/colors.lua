function Colors(color)
  -- require('rose-pine').setup { disable_italics = true }
  -- color = color or 'bluloco'
  -- color = color or 'nordfox'
  local ligth_theme = false
  local transparent_background = true

  color = color or 'sonokai'
  -- color = color or 'zenbones'
  -- color = color or 'ayu'
  -- color = color or 'onenord'
  -- color = color or 'bamboo-light'
  -- color = color or 'dawnfox'
  -- color = color or 'catppuccin-mocha'
  -- color = color or 'caret'
  -- color = color or 'tokyonight-storm'
  -- color = color or 'tokyonight-day'
  -- color = color or 'tokyonight'
  -- color = color or "rose-pine"
  -- color = color or "catppuccin-latte"
  -- color = color or "github_dark_tritanopia"
  -- vim.o.background = 'light'

  -- Set colorscheme after options
  vim.cmd.colorscheme(color)

  -- Set background
  if ligth_theme then
    vim.o.background = 'light'
    transparent_background = false
  else
    vim.o.background = 'dark'
  end

  -- transparent background if it's dark_theme
  if transparent_background then
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
  end

  -- Number Colors/Higlights
  -- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
  -- vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
  -- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = true })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#7DA3D2', bold = true })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = '#CCCCCC', bold = true })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#7DA3D2', bold = true })
end

Colors()
