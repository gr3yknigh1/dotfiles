-- lua/core/apperience.lua
-- apperience settings

vim.g.colorscheme = 'gruvbox' -- 'gruvbox', 'dracula', 'nord'
vim.o.background  = 'light' -- 'dark', 'light'

vim.cmd('syntax enable')
vim.cmd('colorscheme ' .. vim.g.colorscheme)

vim.g.nord_contrast = false
vim.g.nord_borders = true
vim.g.nord_cursorline_transparent = false
vim.g.nord_disable_background = true
vim.g.nord_enable_sidebar_background = true
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
