return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer', -- Required
        {
          'L3MON4D3/LuaSnip',
          build = (function()
            -- Build Step is needed for regex support in snippets.
            -- This step is not supported in many windows environments.
            -- Remove the below condition to re-enable on windows.
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
              return
            end
            return 'make install_jsregexp'
          end)(),
          dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
          },
        },
        -- {
        --   'zbirenbaum/copilot.lua',
        --   opts = {
        --     suggestion = { auto_trigger = true, debounce = 150, enabled = true },
        --     panel = {
        --       enabled = true,
        --       auto_refresh = true,
        --       keymap = {
        --         jump_prev = '[[',
        --         jump_next = ']]',
        --         accept = '<CR>',
        --         refresh = 'gr',
        --         open = '<M-CR>',
        --       },
        --       layout = {
        --         position = 'right', -- | top | left | right
        --         ratio = 0.4,
        --       },
        --     },
        --     server_opts_overrides = {
        --       settings = {
        --         advanced = {
        --           inlineSuggestCount = 5,
        --         },
        --       },
        --     },
        --   },
        -- },
        -- {
        --   'zbirenbaum/copilot-cmp',
        --   opts = function()
        --     return {}
        --   end,
        --   config = function()
        --     return {}
        --   end,
        -- },
      },
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'

      -- local copilot = require 'copilot.suggestion'
      local snip_status_ok, luasnip = pcall(require, 'luasnip')
      luasnip.config.setup {}

      if not snip_status_ok then
        return
      end

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),
          --
          ['<Tab>'] = cmp.mapping(function(fallback)
            -- if copilot.is_visible() then
            --   copilot.accept()
            if cmp.visible() then
              -- elseif cmp.visible() then
              -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
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

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = false },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),
          --
          -- ['<C-x>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.next()
          --   end
          -- end),
          --
          -- ['<C-z>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.prev()
          --   end
          -- end),
          --
          -- ['<C-right>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.accept_word()
          --   end
          -- end),
          --
          -- ['<C-l>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.accept()
          --   end
          -- end),
          --
          -- ['<C-down>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.accept_line()
          --   end
          -- end),
          --
          -- ['<C-j>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.accept_line()
          --   end
          -- end),
          --
          -- ['<C-c>'] = cmp.mapping(function()
          --   if copilot.is_visible() then
          --     copilot.dismiss()
          --   end
          -- end),

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

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        },
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
