local dap = require('dap')
local mason_nvim_dap = require("mason-nvim-dap")

mason_nvim_dap.setup({
  ensure_installed = {},
  automatic_installation = true,
  automatic_setup = true,
})

mason_nvim_dap.setup_handlers({
  function(source_name)
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

