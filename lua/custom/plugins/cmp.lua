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
      },
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local keymaps = require 'custom.keymaps.cmp'
      local snip_status_ok, luasnip = pcall(require, 'luasnip')

      luasnip.config.setup {}

      if not snip_status_ok then
        return
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = keymaps,

        -- For an understanding of why these mappings were
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
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
