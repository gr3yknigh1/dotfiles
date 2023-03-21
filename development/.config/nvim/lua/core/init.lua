-- lua/core/init.lua
-- Basic settings

require('core.keymaps')
require('core.apperience')
require('core.neovide')

local au = require('au')

vim.opt.shell = 'fish'

-- vim.opt.termguicolors = true
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.colorcolumn='80'

vim.opt.numberwidth = 2
vim.opt.cursorline = true

vim.opt.encoding='utf-8'
vim.opt.fileformat='unix'

vim.opt.wrap = true
vim.opt.scrolloff = 5

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'trail:~'
vim.opt.listchars:append 'eol:¶'
vim.opt.listchars:append 'tab:>~'
vim.opt.list = true

vim.opt.clipboard:append 'unnamedplus'

-- Mouse
vim.opt.mouse = 'a'

-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentations
local indentation_size = 4
vim.opt.tabstop     = indentation_size
vim.opt.shiftwidth  = indentation_size
vim.opt.softtabstop = indentation_size
vim.opt.autoindent  = true
vim.opt.smartindent  = true
vim.opt.expandtab   = true

-- Terminal autoinsert
au({ 'BufWinEnter', 'WinEnter' }, {
  'term://*',
  function()
    vim.cmd('startinsert')
  end
})

au.BufLeave = {
  'term://*',
  function()
    vim.cmd('stopinsert')
  end
}

