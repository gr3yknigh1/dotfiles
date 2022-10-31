-- Telescope

local utils = require("utils")
local nmap = utils.nmap

local telescope = require("telescope")
local tactions  = require("telescope.actions")
local tbuiltin  = require("telescope.builtin")


telescope.setup({
  defaults = {
    file_ignore_patterns = {
      -- "**/.git/*",
      -- "**/node_modules/*",
      -- "**/.mono/*",
      -- ".egg-info",
      -- "**/__pycache__/*",
      -- "build/*"
    },
    mappings = {
      i = {
        ["<esc>"] = tactions.close
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=always',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    }
  }, -- defaults

  pickers = {
    find_files = {
      find_command = { "fd", "--strip-cwd-prefix", "-t", "f"},

      -- hidden = true,
      -- no_ignore = true,
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
  } -- extentions
})

telescope.load_extension("file_browser")

nmap("<Leader>ff", tbuiltin.find_files)
nmap("<Leader>fg", tbuiltin.live_grep)
nmap("<Leader>fs", tbuiltin.buffers)
nmap("<Leader>fh", tbuiltin.help_tags)
nmap("<Leader>fc", tbuiltin.commands)
nmap("<Leader>fb", "<cmd>Telescope file_browser<CR>")


