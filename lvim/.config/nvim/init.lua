-- @gr3yknigh1
-- 2022
--
-- Neovim's lua configuration


require("basic")
require("packer-setup")

require("keybindings")
require("lsp")
require("treesitter-setup")


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
  local font_size = 16
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

  vim.g.neovide_fullscreen = true

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
end


-- Plugins
require("plugins.barbar")
require("plugins.bufferline")
require("plugins.db")
require("plugins.indent_blanklines")
require("plugins.lualine")
require("plugins.nvim_tree")
require("plugins.telescope")
require("plugins.treesitter")


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

