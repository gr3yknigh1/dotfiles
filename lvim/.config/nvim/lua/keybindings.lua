-- @gr3yknigh1
-- 2022
-- 
-- Keybindings

utils = require("utils")

map = utils.map
nmap = utils.nmap
vmap = utils.vmap
vnmap = utils.vnmap
tmap = utils.tmap


vim.g.mapleader = "\\"

vnmap("<Leader>R", "<cmd>set list!<CR>")
nmap("<Leader>h", "<cmd>noh<CR>")

map({"t", "n"}, "<Leader>q", "<cmd>q<CR>")

-- Saving
nmap("<C-s>", "<cmd>write<CR>")

-- Coping
vmap("<C-y>", "\"+y")
nmap("<C-p>", "\"+p")


-- Tabs
nmap("<Leader><C-t>", "<cmd>tabnew<CR>")
nmap("<Leader><C-w>", "<cmd>tabclose<CR>")
nmap("<Leader><Tab>", "<cmd>tabnext<CR>")
nmap("<Leader><S-Tab>", "<cmd>tabprevious<CR>")

tmap("<Leader><Tab>", "<Leader><ESC><cmd>tabnext<CR>")
tmap("<Leader><S-Tab>", "<Leader><ESC><cmd>tabprevious<CR>")


-- Panes
nmap("<Leader>\\", "<cmd>vsplit<CR>")
nmap("<Leader>-", "<cmd>split<CR>")


-- Pane switching
nmap("<A-j>", "<C-W>j")
nmap("<A-k>", "<C-W>k")
nmap("<A-h>", "<C-W>h")
nmap("<A-l>", "<C-W>l")


-- Terminal
nmap("<Leader>tt", "<cmd>term<CR>i")
tmap("<Leader><ESC>", "<C-\\><C-n>")


-- Terminal pane switching
tmap("<A-j>", "<C-\\><C-n><C-W>j")
tmap("<A-k>", "<C-\\><C-n><C-W>k")
tmap("<A-h>", "<C-\\><C-n><C-W>h")
tmap("<A-l>", "<C-\\><C-n><C-W>l")


-- Pane resizing
local step = 1

nmap("<C-A-j>", step .. "<C-W>+")
nmap("<C-A-k>", step .. "<C-W>-")
nmap("<C-A-h>", step .. "<C-W><")
nmap("<C-A-l>", step .. "<C-W>>")

-- Pane shifting
-- nmap("<S-A-j>", "<C-W><S-j>")
-- nmap("<S-A-k>", "<C-W><S-k>")
-- nmap("<S-A-h>", "<C-W><S-h>")
-- nmap("<S-A-l>", "<C-W><S-l>")


-- Moving lines
nmap("<S-k>", "<S-v>xkP")
nmap("<S-j>", "<S-v>xp")
