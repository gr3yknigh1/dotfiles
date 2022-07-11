-------------
-- General --
-------------

vim.g.mapleader = '\\'

-- Rendering whitespace
vim.opt.listchars = { eol = '¶', trail = '~', space = '·', tab = '>~' }
vim.opt.list = false
vim.keymap.set({'n', 'v'}, '<Leader>w', function() vim.opt.list = not vim.opt.list:get() end)

-- File formats
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"

-- Wrapping
vim.opt.wrap = true

-- Mouse
vim.opt.mouse = 'a'

-- Indentations
local indent = 4
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent

vim.opt.autoindent = true
vim.opt.expandtab = true

-- Scrolling
vim.opt.scrolloff = 7

-- Compatible
-- NOTE: Neovim is always not compatible
-- vim.opt.nocompatible = true 

-- Line numbers
vim.opt.relativenumber = true
vim.opt.rnu = true

-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Searching
vim.keymap.set({'n', 'v'}, '<Leader>n', function)

-------------
-- Plugins --
-------------

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'arcticicestudio/nord-vim'

vim.call('plug#end')

----------------
-- Apperience --
----------------

vim.cmd('syntax enable')
vim.cmd('colorscheme nord')
