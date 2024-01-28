--
-- init.lua
--

vim.g.mapleader = '\\'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup({
  -- LSP
  require("gr3yknigh1.lazy.nvim-lspconfig"),

  -- UI
  require("gr3yknigh1.lazy.neo-tree"),

  -- Tools
  require("gr3yknigh1.lazy.telescope"),

  -- Colors
  {
    "nordtheme/vim",
    name = "nordtheme",
    init = function()
      vim.cmd [[colorscheme nord]]
    end
  },

  -- syntax
  require("gr3yknigh1.lazy.nvim-treesitter"),

  -- etc
  require("gr3yknigh1.lazy.Comment"),
  require("gr3yknigh1.lazy.nvim-surround"),

  -- etc/folke
  { "folke/which-key.nvim" },
  { "folke/neoconf.nvim",   cmd = "Neoconf" },
  {
    "folke/neodev.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
})

-- Colors and syntax
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

vim.cmd [[syntax enable]]

-- Cursor
vim.opt.cursorline = true

-- Format and encoding
vim.opt.encoding = 'utf-8'
-- vim.opt.fileformat = 'unix'

-- Folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.cmd[[set nofoldenable]]

-- Scrolling and wrapping
vim.opt.wrap = false
vim.opt.scrolloff = 5

-- Mouse
vim.opt.mouse = 'a'

-- Number column
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.number = true

-- Whitespace rendering
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'trail:~'
vim.opt.listchars:append 'eol:↲'
vim.opt.listchars:append 'tab:» '
vim.opt.list = true

-- Use system clipboard
vim.opt.clipboard:append 'unnamedplus'

-- Splitting
vim.opt.splitbelow     = true
vim.opt.splitright     = true

-- Indentations
local indentation_size = 4
vim.opt.tabstop        = indentation_size
vim.opt.shiftwidth     = indentation_size
vim.opt.softtabstop    = indentation_size
vim.opt.autoindent     = true
vim.opt.smartindent    = true
vim.opt.expandtab      = true

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

local function is_file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
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
    if is_file_exists(vim.fn.getcwd() .. '/Makefile') then
      set_make_keybinds()
    end
  end,
})

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
if is_file_exists("~/Applications/TLauncher/TLauncher-2.895.jar") then
  vim.keymap.set('n', '<leader>mf', '<cmd>!java -jar ~/Applications/TLauncher/TLauncher-2.895.jar<CR>')
else
  vim.keymap.set('n', '<leader>mf', function() print("Unable to find TLauncher.jar") end)
end


-- NOTE: Move to custom plugin
if vim.g.neovide then
  local function get_guifont(font_name, font_size)
    return font_name .. ':h' .. tostring(font_size)
  end

  local font_name                       = 'JetBrainsMono Nerd Font'
  vim.g.neovide_padding_top             = 0
  vim.g.neovide_padding_bottom          = 0
  vim.g.neovide_padding_right           = 0
  vim.g.neovide_padding_left            = 0

  vim.g.neovide_refresh_rate            = 60
  vim.g.neovide_refresh_rate_idle       = 5

  vim.g.neovide_profiler                = false

  local default_font_size               = 20
  local font_size                       = default_font_size

  vim.opt.guifont                       = get_guifont(font_name, font_size)

  vim.g.neovide_scale_factor            = 1.0
  vim.g.neovide_transparency            = 1.0
  vim.g.transparency                    = 1.0

  vim.g.neovide_floating_blur_amount_x  = 2.0
  vim.g.neovide_floating_blur_amount_y  = 2.0

  vim.g.neovide_scroll_animation_length = 0.3

  vim.g.neovide_fullscreen              = false
  vim.g.neovide_cursor_trail_size       = 0.4
  vim.g.neovide_hide_mouse_when_typing  = true

  vim.g.neovide_cursor_vfx_mode         = 'sonicboom'

  vim.keymap.set('n', '<C-=>', function()
    font_size = font_size + 1;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)
  vim.keymap.set('n', '<C-->', function()
    font_size = font_size - 1;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)
  vim.keymap.set('n', '<C-0>', function()
    font_size = default_font_size;
    vim.opt.guifont = get_guifont(font_name, font_size)
  end)

  vim.keymap.set('t', '<S-Space>', '<Space>')
  vim.keymap.set('t', '<C-S-Space>', '<Space>')
end
