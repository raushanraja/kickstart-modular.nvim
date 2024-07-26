local ensure_installed = {
  'autoflake',
  'autopep8',
  'lua-language-server',
  'css-lsp',
  'html-lsp',
  'typescript-language-server',
  'deno',
  'pyright',
  'rust-analyzer',
  'rustfmt',
  'mypy',
  'debugpy',
}

return {

  {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    build = function()
      pcall(vim.cmd, 'MasonInstallAll')
    end,
    config = function()
      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
      end, {})

      vim.g.mason_binaries_list = ensure_installed
      require('mason').setup {
        ui = {
          icons = {
            package_pending = ' ',
            package_installed = ' ',
            package_uninstalled = ' ﮊ',
          },

          keymaps = {
            toggle_server_expand = '<CR>',
            install_server = 'i',
            update_server = 'u',
            check_server_version = 'c',
            update_all_servers = 'U',
            check_outdated_servers = 'C',
            uninstall_server = 'X',
            cancel_installation = '<C-c>',
          },
        },
      }
    end,
  },
}
