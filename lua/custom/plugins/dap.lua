return {
  -- ... other plugins ...

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui', -- Ensure dapui is installed as a dependency
      {
        'nvim-neotest/neotest',
        dependencies = {
          'nvim-neotest/nvim-nio',
          'nvim-lua/plenary.nvim',
          'antoinemadec/FixCursorHold.nvim',
          'nvim-treesitter/nvim-treesitter',

          'mxsdev/nvim-dap-vscode-js',
          -- build debugger from source
          {
            'microsoft/vscode-js-debug',
            version = '1.x',
            build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
          },
        },
      },
    },
    config = function()
      local dap = require 'dap'

      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      for _, language in ipairs { 'typescript', 'javascript', 'svelte' } do
        dap.configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = 'pwa-node',
            -- attach to an already running node process with --inspect flag
            -- default port: 9222
            request = 'attach',
            -- allows us to pick the process using a picker
            processId = require('dap.utils').pick_process,
            -- name of the debug action you have to select for this config
            name = 'Attach debugger to existing `node --inspect` process',
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              '${workspaceFolder}/**',
              '!**/node_modules/**',
            },
            -- path to src in vite based projects (and most other projects as well)
            cwd = '${workspaceFolder}/src',
            -- we don't want to debug code inside node_modules, so skip it!
            skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
          },
          {
            type = 'pwa-chrome',
            name = 'Launch Chrome to debug client',
            request = 'launch',
            url = 'http://localhost:5173',
            sourceMaps = true,
            protocol = 'inspector',
            port = 9222,
            webRoot = '${workspaceFolder}/src',
            -- skip files from vite's hmr
            skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
          },
          -- only if language is javascript, offer this debug action
          language == 'javascript'
              and {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = 'pwa-node',
                -- launch a new process to attach the debugger to
                request = 'launch',
                -- name of the debug action you have to select for this config
                name = 'Launch file in new node process',
                -- launch current file
                program = '${file}',
                cwd = '${workspaceFolder}',
              }
            or nil,
        }
      end

      dap.adapters.codelldb = {
        ident = 'codelldb',
        type = 'executable',
        command = '/home/rr/.local/share/nvim/mason/bin/codelldb',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- Get the rust debug executable name from the cargo.toml file
            local cargo_toml = io.open('Cargo.toml', 'r')
            if cargo_toml then
              for line in cargo_toml:lines() do
                if line:match '^name%s*=%s*"([^"]+)"' then
                  local name = line:match '^name%s*=%s*"([^"]+)"'
                  cargo_toml:close()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/' .. name, 'file')
                end
              end
              cargo_toml:close()
            end
            -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.configurations.rust = dap.configurations.cpp

      dap.listeners.after.event_initialized['dapui_config'] = function()
        require('dapui').open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        require('dapui').close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        require('dapui').close()
      end
    end,
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'Debug: Continue',
        silent = true,
      },
      {
        '<F10>',
        function()
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
        silent = true,
      },
      {
        '<F11>',
        function()
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
        silent = true,
      },
      {
        '<F12>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
        silent = true,
      },
      {
        '<Leader>bb',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
        silent = true,
      },
      {
        '<Leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint (Conditional)',
        silent = true,
      },
      {
        '<Leader>lp',
        function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end,
        desc = 'Debug: Set Log Point',
        silent = true,
      },
      {
        '<Leader>dr',
        function()
          require('dap').repl.open()
        end,
        desc = 'Debug: Open REPL',
        silent = true,
      },
      {
        '<Leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Debug: Run Last',
        silent = true,
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap', --Make sure dapui is installed only if dap is.
    },
    config = function()
      require('dapui').setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        -- Use this to override mappings for specific elements
        element_mappings = {
          -- Example:
          -- stacks = {
          --   open = "<CR>",
          --   expand = "o",
          -- }
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has 'nvim-0.7' == 1,
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 25 lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40, -- 40 columns
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25, -- 25% of total lines
            position = 'bottom',
          },
        },
        controls = {
          -- Requires Neovim nightly (or 0.8 when released)
          enabled = true,
          -- Display controls in this element
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '↻',
            terminate = '□',
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = 'single', -- "single", "double" or "rounded"
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      }
    end,
  },
}
