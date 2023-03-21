-- Telescope

local telescope = require("telescope")
local tactions  = require("telescope.actions")
local tbuiltin  = require("telescope.builtin")


telescope.setup({
  defaults = {
    file_ignore_patterns = {
      ".git",
      "^node_modules",
      "^vendor",
    },
    mappings = {
      i = {
        ["<esc>"] = tactions.close
      },
    },
    -- vimgrep_arguments = {
    --   'rg',
    --   '--color=always',
    --   '--no-heading',
    --   '--with-filename',
    --   '--line-number',
    --   '--column',
    --   '--smart-case',
    --   '--ignore-file',
    --   '.gitignore',
    -- }
  }, -- defaults

  pickers = {
    find_files = {
      -- find_command = { "fd", "--strip-cwd-prefix", "-t", "f"},
      hidden = true,
    }
  }, -- pickers

  extentions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
        },
        ["n"] = {
        },
      },
    }, -- file_browser
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      }
    } -- command_palette
  } -- extentions
})

require('telescope').load_extension("file_browser")
require('telescope').load_extension('command_palette')

vim.keymap.set('n', "<Leader>ff", tbuiltin.find_files)
vim.keymap.set('n', "<Leader>fg", tbuiltin.live_grep)
vim.keymap.set('n', "<Leader>fs", tbuiltin.buffers)
vim.keymap.set('n', "<Leader>fh", tbuiltin.help_tags)
vim.keymap.set('n', "<Leader>p", tbuiltin.commands)
vim.keymap.set('n', "<Leader>fb", "<cmd>Telescope file_browser<CR>")


