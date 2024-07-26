return {
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
  },
  {
    'f-person/git-blame.nvim',
    event = 'BufRead',
    config = function()
      vim.cmd 'highlight default link gitblame SpecialComment'
      vim.g.gitblame_enabled = 0
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
  },
  {
    'kdheepak/lazygit.nvim',
  },
}

