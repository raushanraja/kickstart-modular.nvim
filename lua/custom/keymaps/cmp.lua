local cmp = require 'cmp'
local copilot = require 'copilot.suggestion'

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local keymaps = cmp.mapping.preset.insert {
  ['<Tab>'] = cmp.mapping(function(fallback)
    if copilot.is_visible() then
      copilot.accept()
    elseif cmp.visible() then
      cmp.select_next_item()
    elseif vim.snippet.active { direction = 1 } then
      vim.schedule(function()
        vim.snippet.jump(1)
      end)
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { 'i', 's' }),

  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<CR>'] = cmp.mapping.confirm { select = false },
  ['<C-Space>'] = cmp.mapping.complete {},
  ['<C-x>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.next()
    end
  end),
  ['<C-z>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.prev()
    end
  end),
  ['<C-right>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.accept_word()
    end
  end),
  ['<C-l>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.accept()
    end
  end),
  ['<C-down>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.accept_line()
    end
  end),
  ['<C-j>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.accept_line()
    end
  end),
  ['<C-c>'] = cmp.mapping(function()
    if copilot.is_visible() then
      copilot.dismiss()
    end
  end),
  ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif vim.snippet.active { direction = -1 } then
      vim.schedule(function()
        vim.snippet.jump(-1)
      end)
    else
      fallback()
    end
  end, { 'i', 's' }),
}

return keymaps
