local dap = require('dap')

-- @NOTE variables
-- ${file}: Active filename
-- ${fileBasename}: The current file's basename
-- ${fileBasenameNoExtension}: The current file's basename without extension
-- ${fileDirname}: The current file's dirname
-- ${fileExtname}: The current file's extension
-- ${relativeFile}: The current file relative to |getcwd()|
-- ${relativeFileDirname}: The current file's dirname relative to |getcwd()|
-- ${workspaceFolder}: The current working directory of Neovim
-- ${workspaceFolderBasename}: The name of the folder opened in Neovim
-- ${command:pickProcess}: Open dialog to pick process using |vim.ui.select|
-- ${env:Name}: Environment variable named `Name`, for example: `${env:HOME}`.


local function resolve_python_interpreter()
  return '/usr/bin/python'
end


dap.adapters.python = {
  type = 'executable';
  command = resolve_python_interpreter();
  args = { '-m', 'debugpy.adapter' };
}

dap.adapters.lldb = {
  type = "executable",
  command = vim.fn.exepath("lldb-vscode"),
  name =  "lldb",
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return resolve_python_interpreter()
    end;
  },
}


dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
vim.keymap.set('n', '<leader>do', dap.step_over)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>dt', dap.step_out)
vim.keymap.set('n', '<leader>dk', dap.continue)
vim.keymap.set('n', '<leader>dl', dap.run_last)
vim.keymap.set('n', '<leader>b',  dap.toggle_breakpoint)

