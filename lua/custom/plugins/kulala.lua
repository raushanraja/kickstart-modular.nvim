return {
  -- HTTP REST-Client Interface
  'mistweaverco/kulala.nvim',
  opts = {
    -- default_view: headers_body, headers, body
    default_view = 'headers_body',
    default_winbar_panes = { 'body', 'headers', 'headers_body', 'script_output' },
    -- enable winbar
    winbar = true,
  },
}
