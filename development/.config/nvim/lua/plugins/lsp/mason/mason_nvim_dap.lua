local dap = require('dap')
local mason_nvim_dap = require("mason-nvim-dap")

mason_nvim_dap.setup({
    -- A list of adapters to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {},

    -- NOTE: this is left here for future porting in case needed
    -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "python", "delve" } }
    automatic_installation = true,

    -- Whether adapters that are installed in mason should be automatically set up in dap.
    -- Removes the need to set up dap manually.
    -- See mappings.adapters and mappings.configurations for settings.
    -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
    -- Can either be:
    --     - false: Dap is not automatically configured.
    --     - true: Dap is automatically configured.
    --     - {adapters: {ADAPTER: {}, }, configurations: {ADAPTER: {}, }}. Allows overriding default configuration.
    automatic_setup = true,
})

require 'mason-nvim-dap'.setup_handlers({
  function(source_name)
    -- all sources with no handler get passed here

    -- Keep original functionality of `automatic_setup = true`
    require('mason-nvim-dap.automatic_setup')(source_name)
  end,

  python = function(source_name)
    dap.adapters.python = {
      type = "executable",
      command = "/usr/bin/python3",
      args = {
        "-m",
        "debugpy.adapter",
      },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
      },
    }
  end,

  lldb = function(source_name)
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = 'lldb'
    }
    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
        env = function()
          local variables = {}
          for k, v in pairs(vim.fn.environ()) do
            table.insert(variables, string.format('%s=%s', k, v))
          end
          return variables
        end,
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
})

