return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
  },
  -- autopairing of (){}[] etc
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
  { 'tpope/vim-surround' },
}
