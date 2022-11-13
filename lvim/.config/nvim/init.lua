-- @gr3yknigh1
-- 2022
--
-- Neovim's lua configuration


require("basic")
require("packer-setup")

require("keybindings")
require("lsp")

local utils = require("utils")
local map = utils.map


-- VSCode Neovim configuration
-- Remappings for VSCode Neovim extention
-- TODO:
--   - [ ] Closing tabs
--   - [ ] Tab scroll
--   - [ ] Telescope integration
if vim.fn.exists("g:vscode") == 1 then
  print("Hello from VSCode!")
  -- NOTE(gr3yknigh1): Doesn't working :c
  -- Dunno why
  vim.keymap.set('n', '<A-,>', '<cmd>tabprevious<cr>')
  vim.keymap.set('n', '<A-.>', '<cmd>tabnext<cr>')
end


-- Neovide configuration
-- @NOTE Configuration documentation link
-- @LINK https://neovide.dev/configuration.html
if vim.fn.exists("g:neovide") and vim.g.neovide then
  print("Hello from Neovide!")

  local font_name = "Iosevka Nerd Font"
  local default_font_size = 11
  local font_size = default_font_size
  local function get_guifont()
    return font_name .. ":h" .. tostring(font_size)
  end

  vim.opt.guifont = get_guifont()

  vim.g.neovide_scale_factor = 1.0

  -- vim.g.neovide_transparency = 1
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
  -- vim.g.neovide_floating_blur_amount_x = 2.0
  -- vim.g.neovide_floating_blur_amount_y = 2.0
  -- vim.g.neovide_scroll_animation_length = 0.3

  vim.g.neovide_fullscreen = false

  vim.g.neovide_cursor_trail_size = 0.4

  -- @NOTE Avaiable options for vim.g.neovide_cursor_vfx_mode:
  --   - railgun
  --   - torpedo
  --   - pixiedust
  --   - sonicboom
  --   - ripple
  --   - wireframe
  vim.g.neovide_cursor_vfx_mode = "ripple"

  map("n", "<C-=>", function()
    font_size = font_size + 1;
    vim.opt.guifont = get_guifont()
  end)
  map("n", "<C-->", function()
    font_size = font_size - 1;
    vim.opt.guifont = get_guifont()
  end)
  map("n", "<C-0>", function()
    font_size = default_font_size;
    vim.opt.guifont = get_guifont()
  end)
end


-- Plugins
require("plugins.packer")

require("plugins.bufferline")
require("plugins.indent_blanklines")
require("plugins.lualine")
require("plugins.nvim_tree")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lazygit")
require("plugins.db")

-- Colorscheme

vim.cmd("syntax enable")
vim.cmd("colorscheme nord")

vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_cursorline_transparent = false
vim.g.nord_disable_background = true
vim.g.nord_enable_sidebar_background = true
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true


local dap = require('dap')
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
        table.insert(variables, string.format("%s=%s", k, v))
      end
      return variables
    end,
  },
}


dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set('n', "<leader>do", dap.step_over)
vim.keymap.set('n', "<leader>di", dap.step_into)
vim.keymap.set('n', "<leader>dt", dap.step_out)
vim.keymap.set('n', '<leader>dk', dap.continue)
vim.keymap.set('n', '<leader>dl', dap.run_last)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25,
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
    max_value_lines = 100,
  }
})

require("nvim-dap-virtual-text").setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = '<module',

    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
}

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

