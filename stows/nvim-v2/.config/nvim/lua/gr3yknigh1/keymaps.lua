-- -- Keymaps -- --
vim.keymap.set('n', ';', ':')

-- Saving
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>s', '<cmd>wa<CR>')

-- Append new lines
vim.keymap.set('n', 'mm', 'o<Esc>k');
vim.keymap.set('n', 'MM', 'O<Esc>j');

-- Pane splitting
vim.keymap.set('n', '<leader>\\', '<cmd>vsplit<CR>')
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>')

-- Pane focusing
vim.keymap.set('n', '<A-j>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<A-k>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<A-h>', '<C-W>h', { silent = true })
vim.keymap.set('n', '<A-l>', '<C-W>l', { silent = true })

-- Pane resizing
local pane_resize_step = 2
vim.keymap.set('n', '<C-A-j>', pane_resize_step .. '<C-W>+')
vim.keymap.set('n', '<C-A-k>', pane_resize_step .. '<C-W>-')
vim.keymap.set('n', '<C-A-h>', pane_resize_step .. '<C-W><')
vim.keymap.set('n', '<C-A-l>', pane_resize_step .. '<C-W>>')

-- Pane movement
vim.keymap.set('n', '<A-H>', '<C-W>H');
vim.keymap.set('n', '<A-J>', '<C-W>J');
vim.keymap.set('n', '<A-K>', '<C-W>K');
vim.keymap.set('n', '<A-L>', '<C-W>L');

-- TODO: move line
-- nmap('<S-k>', '<S-v>xkP')
-- nmap('<S-j>', '<S-v>xp')


-- Very important bindings, thanks tj
vim.keymap.set('', '<Up>', '<cmd>echo "---> k <---"<CR>')
vim.keymap.set('', '<Down>', '<cmd>echo "---> j <---"<CR>')
vim.keymap.set('', '<Left>', '<cmd>echo "---> h <---"<CR>')
vim.keymap.set('', '<Right>', '<cmd>echo "---> l <---"<CR>')

-- Unmapping default maps
vim.keymap.set('n', '<C-w>s', '')
vim.keymap.set('n', '<C-w>v', '')
vim.keymap.set('n', '<C-w>h', '')
vim.keymap.set('n', '<C-w>j', '')
vim.keymap.set('n', '<C-w>k', '')
vim.keymap.set('n', '<C-w>l', '')
vim.keymap.set('n', '<C-\\><C-n>', '')


-- Open hh.ru
-- TODO: Check if xdg-open exists
vim.keymap.set('n', '<leader>hh', '<cmd>!xdg-open https://hh.ru/vacancies/c_plus_plus_developer<CR>')

-- Open Minecraft
-- TODO: Replace with proper file existing function
-- TODO: Check if java exec is exists
if require("nostdlib.fs").is_file_exists("~/Applications/TLauncher/TLauncher-2.895.jar") then
  vim.keymap.set('n', '<leader>mf', '<cmd>!java -jar ~/Applications/TLauncher/TLauncher-2.895.jar<CR>')
else
  vim.keymap.set('n', '<leader>mf', function() print("Unable to find TLauncher.jar") end)
end


-- NOTE: Makefile bindings
-- TODO: Replace with local plugin
local function set_make_keybinds()
  vim.keymap.set('n', '<leader>mf', '<cmd>make format<cr>')
  vim.keymap.set('n', '<leader>ma', '<cmd>make all<cr>')
  vim.keymap.set('n', '<leader>mc', '<cmd>make clean<cr>')
  vim.keymap.set('n', '<leader>mr', '<cmd>make run<cr>')
  vim.keymap.set('n', '<leader>mt', '<cmd>make tests<cr>')
end

vim.api.nvim_create_autocmd({ "DirChanged" }, {
  callback = function()
    -- TODO: Replace with `plenary.lua` func from `path` module
    if require("nostdlib.fs").is_file_exists(vim.fn.getcwd() .. '/Makefile') then
      set_make_keybinds()
    end
  end,
})
