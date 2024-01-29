--
-- init.lua
--

vim.g.mapleader = '\\'

local lazypath = require("nostdlib.fs").path_join(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---@diagnostic disable-next-line: different-requires
require("lazy").setup(require("gr3yknigh1.plugins"), require("gr3yknigh1.plugins.lazy"))

require("gr3yknigh1.settings")
require("gr3yknigh1.keymaps")
require("gr3yknigh1.neovide")
