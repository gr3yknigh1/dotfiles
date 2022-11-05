-- @gr3yknigh1
-- 2022
--
-- Basic settings

local shell = "fish"
vim.opt.shell = shell

vim.opt.termguicolors = true

-- if vim.fn.has("termguicolors") then
--   vim.opt.termguicolors = true
-- end

local au = require("au")


vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.colorcolumn="90"

vim.opt.numberwidth = 2
vim.opt.cursorline = true

-- File formats
vim.opt.encoding="utf-8"
vim.opt.fileformat="unix"


-- Wrapping
vim.opt.wrap = false
vim.opt.scrolloff = 7


-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

au.BufEnter = {
  "*.*",
  function()
    vim.cmd("set relativenumber")
  end
}

au.TermOpen = {
  "*",
  function()
    vim.cmd("set nonumber norelativenumber")
  end
}

-- Rendering whitespace
-- vim.opt.listchars = {
--   eol = "¶",
--   trail = "~",
--   space = "·",
--   tab = ">~"
-- }

-- vim.opt.listchars:append "space: "
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "trail:~"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "tab:>~"
vim.opt.list = false


-- Mouse
vim.opt.mouse = "a"


-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true


-- Indentations
local indent = 4
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = -1

vim.opt.autoindent = true
vim.opt.expandtab = true

-- Terminal autoinsert

au({ "BufWinEnter", "WinEnter" }, {
  "term://*",
  function()
    vim.cmd("startinsert")
  end
})

au.BufLeave = {
  "term://*",
  function()
    vim.cmd("stopinsert")
  end
}

-- Folding

-- vim.opt.foldmethod="expr"
