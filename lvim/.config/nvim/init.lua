-- @gr3yknigh1
-- 2022
-- 
-- Neovim's lua configuration
-- References
--   - (DistroTube) 
--     https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/nvim/init.lua


require("basic")
require("packer-setup")

require("keybindings")
require("lsp")
require("treesitter-setup")

-- Remappings for VSCode Neovim extention
-- TODO:
--   - [ ] Closing tabs
--   - [ ] Tab scroll
--   - [ ] Telescope integration
if vim.fn.exists("g:vscode") == 1 then
  print("hello world!")

  -- NOTE(gr3yknigh1): Doesn't working :c
  -- Dunno why
  vim.keymap.set('n', '<A-,>', '<cmd>tabprevious<cr>')
  vim.keymap.set('n', '<A-.>', '<cmd>tabnext<cr>')
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

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_cursorline_transparent = true
vim.g.nord_disable_background = true
vim.g.nord_enable_sidebar_background = true
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true

