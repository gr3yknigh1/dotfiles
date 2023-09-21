-- lua/core/apperience.lua
-- keymapping

vim.g.mapleader = '\\'

-- close terminal
vim.keymap.set('t', 'ZZ', '<cmd>q<CR>')
vim.keymap.set('t', '<A-c>', '<C-\\><C-n><cmd>bdelete!<cr>')

-- RENDERING
-- render whitespace
vim.keymap.set({'n', 'v'}, '<leader>R', '<cmd>set list!<CR>')
-- toggle nowrap mode
vim.keymap.set('n', '<leader>W', '<cmd>set wrap!<cr>')


-- SEARCING
-- disable search hightlight
vim.keymap.set('n', '<ESC>', '<cmd>noh<CR>')
-- seach selected
-- NOTE: You can search with `*` key
-- vim.keymap.set('v', '/', 'y/<C-r>0<cr>')

-- SAVING
-- saving
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>s', '<cmd>wa<CR>')

-- append new lines
vim.keymap.set('n', 'mm', 'o<Esc>k');
vim.keymap.set('n', 'MM', 'O<Esc>j');

-- tab managment
vim.keymap.set('n', '<leader><C-t>', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader><C-w>', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabprevious<CR>')

vim.keymap.set('t', '<leader><Tab>', '<Leader><ESC><cmd>tabnext<CR>')
vim.keymap.set('t', '<leader><S-Tab>', '<Leader><ESC><cmd>tabprevious<CR>')

-- split panes
vim.keymap.set('n', '<leader>\\', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>')

-- pane switching
vim.keymap.set('n', '<A-j>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<A-k>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<A-h>', '<C-W>h', { silent = true })
vim.keymap.set('n', '<A-l>', '<C-W>l', { silent = true })

-- pane switching terminal
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-W>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-W>k')
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-W>h')
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-W>l')

-- open terminal in current window
vim.keymap.set('n', '<leader>tt', '<cmd>term<CR>i')

-- exit from terminal mode
vim.keymap.set('t', '<leader><ESC>', '<C-\\><C-n>')

-- pane resizing
local pane_resize_step = 2
vim.keymap.set('n', '<C-A-j>', pane_resize_step .. '<C-W>+')
vim.keymap.set('n', '<C-A-k>', pane_resize_step .. '<C-W>-')
vim.keymap.set('n', '<C-A-h>', pane_resize_step .. '<C-W><')
vim.keymap.set('n', '<C-A-l>', pane_resize_step .. '<C-W>>')

-- move pane
vim.keymap.set('n', '<A-H>', '<C-W>H');
vim.keymap.set('n', '<A-J>', '<C-W>J');
vim.keymap.set('n', '<A-K>', '<C-W>K');
vim.keymap.set('n', '<A-L>', '<C-W>L');

-- TODO: move line
-- nmap('<S-k>', '<S-v>xkP')
-- nmap('<S-j>', '<S-v>xp')

vim.keymap.set('n', '<leader>rp', function()
  vim.cmd('vsplit')
  vim.cmd('term python -ic "exec(open(\\"%\\").read(), globals())"')
  vim.cmd('startinsert')
end)

-- MAKE KEYBINDS
local au = require('au')
local utils = require('utils')

local function set_make_keybinds()
  vim.keymap.set('n', '<leader>mf', '<cmd>make format<cr>')
  vim.keymap.set('n', '<leader>ma', '<cmd>make all<cr>')
  vim.keymap.set('n', '<leader>mc', '<cmd>make clean<cr>')
  vim.keymap.set('n', '<leader>mr', '<cmd>make run<cr>')
  vim.keymap.set('n', '<leader>mt', '<cmd>make tests<cr>')
end

if utils.file_exists(vim.fn.getcwd() .. '/Makefile') then
  set_make_keybinds()
end

au({ 'DirChanged' } , {
  '*',
  function()
    -- TODO: Replace with `plenary.lua` func from `path` module
    if utils.file_exists(vim.fn.getcwd() .. '/Makefile') then
      set_make_keybinds()
    end
  end
})

-- unmapping default maps
vim.keymap.set('n', '<C-w>s', '')
vim.keymap.set('n', '<C-w>v', '')
vim.keymap.set('n', '<C-w>h', '')
vim.keymap.set('n', '<C-w>j', '')
vim.keymap.set('n', '<C-w>k', '')
vim.keymap.set('n', '<C-w>l', '')
vim.keymap.set('n', '<C-\\><C-n>', '')

