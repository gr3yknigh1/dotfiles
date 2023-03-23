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
  },

  pickers = {
    find_files = { hidden = true, }
  },

  extentions = {}
})

vim.keymap.set('n', "<Leader>ff", tbuiltin.find_files)
vim.keymap.set('n', "<Leader>fg", tbuiltin.live_grep)

