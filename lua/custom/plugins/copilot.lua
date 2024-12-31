return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = { 'zbirenbaum/copilot-cmp' },
    opts = {
      suggestion = { auto_trigger = true, debounce = 150, enabled = true },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'right', -- | top | left | right
          ratio = 0.4,
        },
      },
      server_opts_overrides = {
        settings = {
          advanced = {
            inlineSuggestCount = 5,
          },
        },
      },
    },
  },
}
