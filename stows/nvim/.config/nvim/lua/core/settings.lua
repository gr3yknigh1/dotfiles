-- lua/core/settings.lua
-- basic editor's settings

-- vim.opt.shell = 'bash'

vim.opt.termguicolors = true
-- if vim.fn.has('termguicolors') then
-- end

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.colorcolumn='80'

vim.opt.numberwidth = 2
vim.opt.cursorline = true

vim.opt.encoding='utf-8'
vim.opt.fileformat='unix'

vim.opt.wrap = false
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
vim.opt.smartindent = true
vim.opt.expandtab   = true

-- AUTOCOMMANDS
local au = require('au')

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

vim.cmd[[let g:c_syntax_for_h = 1]];
