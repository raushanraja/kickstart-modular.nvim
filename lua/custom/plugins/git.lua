return {
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
  },
  {
    'f-person/git-blame.nvim',
    event = 'BufRead',
    opts = {
      enabled = false,
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = true,
  },
  {
    'kdheepak/lazygit.nvim',
  },
}
