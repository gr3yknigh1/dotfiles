if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.backup = true
  vim.opt.cmdheight = 0
  vim.opt.backupdir = require("nostdlib.fs").path_join(vim.fn.stdpath("state"), "backup")
end

vim.g.c_syntax_for_h = true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.colorcolumn = { "80", "120" }

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
