-- lua/core/apperience.lua
-- apperience settings

vim.g.colorscheme = 'nord' -- 'gruvbox', 'gracula', 'nord'
vim.o.background  = 'dark' -- 'dark', 'light'

vim.cmd('syntax enable')
vim.cmd('colorscheme ' .. vim.g.colorscheme)

if vim.g.colorscheme == 'nord' then
  vim.g.nord_contrast = false
  vim.g.nord_borders = true
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_disable_background = true
  vim.g.nord_enable_sidebar_background = true
  vim.g.nord_italic = true
  vim.g.nord_uniform_diff_background = true
end
