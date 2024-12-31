-- Global boolean flag
vim.g.my_boolean_flag = false

-- Command to toggle the flag
vim.api.nvim_create_user_command('ToggleFlag', function()
  vim.g.my_boolean_flag = not vim.g.my_boolean_flag
  print('Terminal Switch', vim.g.my_boolean_flag)
end, {})

-- Function to handle custom behavior for window switching
local function custom_tab_switch()
  if vim.g.my_boolean_flag then
    -- Check if the next window has the `filetype` set to `toggleterm`
    vim.cmd 'wincmd w' -- Switch to the next window temporarily
    local ft = vim.bo.filetype

    if ft == 'toggleterm' then
      vim.cmd 'wincmd w' -- Switch to the next window again
      return
    end
  else
    -- Perform the actual window switching
    vim.cmd 'wincmd w'
  end
end

-- Set up the keymap
vim.api.nvim_set_keymap('n', '<Tab>', '', { noremap = true, silent = true, callback = custom_tab_switch })
-- Set up the keymap for ToggleFlag command
vim.api.nvim_set_keymap('n', '<leader>ll', ':ToggleFlag<CR>', { noremap = true, silent = true })

-- Set up the keymap for the command,
