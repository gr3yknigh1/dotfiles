-- Telescope

local telescope = require('telescope')
local telescope_actions  = require('telescope.actions')
local telescope_builtin  = require('telescope.builtin')

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      '.git',
      '^node_modules',
      '^vendor',
    },
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close
      },
    },
  },

  pickers = {
    find_files = { hidden = true, }
  },

  extentions = {}
})

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)

