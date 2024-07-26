function ExitPrompt()
  -- Check if the current buffer has been modified
  local modified = vim.bo.modified

  -- Prompt the user for saving changes if modified
  if modified then
    -- Prompt the user for saving changes
    local choice = vim.fn.input 'Save changes before exit? (y/n): '
    vim.cmd 'redraw'
    vim.cmd 'echo ""'
    -- If the choice is 'n' or 'N', delete the buffer without saving
    if choice == 'n' or choice == 'N' then
      vim.cmd 'bdelete!'
    else
      -- Save the file and delete the buffer
      vim.cmd 'w | bdelete!'
    end
  else
    -- If the buffer is not modified, simply delete it
    vim.cmd 'bdelete!'
  end
end
