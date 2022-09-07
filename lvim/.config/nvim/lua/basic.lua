-- @gr3yknigh1
-- 2022
-- 
-- Basic configuration

local shell = "fish"

vim.g.mapleader = "\\"
vim.opt.shell = shell

-- Term colors
if vim.fn.has("termguicolors") then vim.opt.termguicolors = true
end

-- File formats
vim.opt.encoding="utf-8"
vim.opt.fileformat="unix"


-- Wrapping
vim.opt.wrap = true
vim.opt.scrolloff = 7


-- Line numbers
vim.opt.relativenumber = true
vim.opt.rnu = true

-- Rendering whitespace
vim.opt.listchars = { eol = "¶", trail = "~", space = "·", tab = ">~" }
vim.opt.list = false


-- Mouse
vim.opt.mouse = "a"


-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true


-- Indentations
local indent = 4
vim.opt.tabstop = indent
vim.opt.shiftwidth = 2
vim.opt.softtabstop = indent

vim.opt.autoindent = true
vim.opt.expandtab = true
