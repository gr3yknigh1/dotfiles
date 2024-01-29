
-- vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Colors and syntax
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

vim.cmd [[syntax enable]]

-- Cursor
vim.opt.cursorline = true

-- Format and encoding
vim.opt.encoding = 'utf-8'
-- vim.opt.fileformat = 'unix'

-- Folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.cmd[[set nofoldenable]]

-- Scrolling and wrapping
vim.opt.wrap = false
vim.opt.scrolloff = 5

-- Mouse
vim.opt.mouse = 'a'

-- Number column
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.number = true

-- Whitespace rendering
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'trail:~'
vim.opt.listchars:append 'eol:↲'
vim.opt.listchars:append 'tab:» '
vim.opt.list = true

-- Use system clipboard
vim.opt.clipboard:append 'unnamedplus'

-- Splitting
vim.opt.splitbelow     = true
vim.opt.splitright     = true

-- Indentations
local indentation_size = 4
vim.opt.tabstop        = indentation_size
vim.opt.shiftwidth     = indentation_size
vim.opt.softtabstop    = indentation_size
vim.opt.autoindent     = true
vim.opt.smartindent    = true
vim.opt.expandtab      = true

