-- Telescope

local utils = require("utils")
local nmap = utils.nmap

local telescope = require("telescope")
local tactions  = require("telescope.actions")
local tbuiltin  = require("telescope.builtin")

telescope.setup({
    defaults = {
        file_ignore_patterns = {
          "**/.git",
          "**/node_modules",
          "**/.mono",
          "**/.import",
          "**/.ccls-cache",
          "**/.obsidian",
          "**/.trash",
          "**/.mypy_cache"
        },
        mappings = {
          i = {
            ["<esc>"] = tactions.close
          },
        },
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--ignore-file",
          ".gitignore"
        },
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
})


nmap("<Leader>ff", tbuiltin.find_files)
nmap("<Leader>fg", tbuiltin.live_grep)
nmap("<Leader>fb", tbuiltin.buffers)
nmap("<Leader>fh", tbuiltin.help_tags)
nmap("<Leader>fc", tbuiltin.commands)
