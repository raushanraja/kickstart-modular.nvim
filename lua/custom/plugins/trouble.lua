local keys = require 'custom.keymaps.trouble'

return {
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = keys,
}
