-- lua/core/apperience.lua
-- KEYMAPPING

vim.g.mapleader = '\\'


vim.keymap.set('n', ';', ':')

-- Close terminal
vim.keymap.set('t', 'ZZ', '<cmd>q<CR>')
vim.keymap.set('t', '<A-c>', '<C-\\><C-n><cmd>bdelete!<cr>')

-- Rendering
-- -- Render whitespace
vim.keymap.set({'n', 'v'}, '<leader>R', '<cmd>set list!<CR>')
-- -- Toggle nowrap mode
vim.keymap.set('n', '<leader>W', '<cmd>set wrap!<cr>')


-- Searcing
-- -- Disable search hightlight
vim.keymap.set('n', '<ESC>', '<cmd>noh<CR>')
-- -- Seach selected
-- NOTE: You can search with `*` key
-- vim.keymap.set('v', '/', 'y/<C-r>0<cr>')

-- Saving
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>s', '<cmd>wa<CR>')

-- Append new lines
vim.keymap.set('n', 'mm', 'o<Esc>k');
vim.keymap.set('n', 'MM', 'O<Esc>j');

-- Tab managment
vim.keymap.set('n', '<leader><C-t>', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader><C-w>', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader><S-Tab>', '<cmd>tabprevious<CR>')

vim.keymap.set('t', '<leader><Tab>', '<Leader><ESC><cmd>tabnext<CR>')
vim.keymap.set('t', '<leader><S-Tab>', '<Leader><ESC><cmd>tabprevious<CR>')

-- Split panes
vim.keymap.set('n', '<leader>\\', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>')

-- Pane switching
vim.keymap.set('n', '<A-j>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<A-k>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<A-h>', '<C-W>h', { silent = true })
vim.keymap.set('n', '<A-l>', '<C-W>l', { silent = true })

-- Pane switching terminal
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-W>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-W>k')
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-W>h')
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-W>l')

-- Open terminal in current window
vim.keymap.set('n', '<leader>tt', '<cmd>term<CR>i')

-- Exit from terminal mode
vim.keymap.set('t', '<leader><ESC>', '<C-\\><C-n>')

-- Pane resizing
local pane_resize_step = 2
vim.keymap.set('n', '<C-A-j>', pane_resize_step .. '<C-W>+')
vim.keymap.set('n', '<C-A-k>', pane_resize_step .. '<C-W>-')
vim.keymap.set('n', '<C-A-h>', pane_resize_step .. '<C-W><')
vim.keymap.set('n', '<C-A-l>', pane_resize_step .. '<C-W>>')

-- Move pane
vim.keymap.set('n', '<A-H>', '<C-W>H');
vim.keymap.set('n', '<A-J>', '<C-W>J');
vim.keymap.set('n', '<A-K>', '<C-W>K');
vim.keymap.set('n', '<A-L>', '<C-W>L');

-- TODO: move line
-- nmap('<S-k>', '<S-v>xkP')
-- nmap('<S-j>', '<S-v>xp')


vim.keymap.set('v', '<C-]>', "<cmd>s/'/\"/g<cr>")
vim.keymap.set('n', '<C-]>', "v<cmd>s/'/\"/g<cr><Esc>")

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

-- Very important bindings
vim.keymap.set('', '<Up>',     '<cmd>echo "---> k <---"<CR>')
vim.keymap.set('', '<Down>',   '<cmd>echo "---> j <---"<CR>')
vim.keymap.set('', '<Left>',   '<cmd>echo "---> h <---"<CR>')
vim.keymap.set('', '<Right>',  '<cmd>echo "---> l <---"<CR>')

-- unmapping default maps
vim.keymap.set('n', '<C-w>s', '')
vim.keymap.set('n', '<C-w>v', '')
vim.keymap.set('n', '<C-w>h', '')
vim.keymap.set('n', '<C-w>j', '')
vim.keymap.set('n', '<C-w>k', '')
vim.keymap.set('n', '<C-w>l', '')
vim.keymap.set('n', '<C-\\><C-n>', '')


vim.keymap.set('n', '<leader>hh', '<cmd>!xdg-open https://hh.ru/vacancies/c_plus_plus_developer<CR>')
vim.keymap.set('n', '<leader>mf', '<cmd>!java -jar ~/Applications/TLauncher/TLauncher-2.895.jar<CR>')

