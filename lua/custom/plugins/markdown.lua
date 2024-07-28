return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  opts = {
    file_types = { 'markdown', 'norg', 'rmd', 'org' },
    code = {
      sign = true,
      width = 'block',
      right_pad = 5,
    },
  },
}
