
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sharkdp/fd',
    'BurntSushi/ripgrep',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope         = require('telescope')
    local telescope_builtin = require('telescope.builtin')
    local telescope_actions = require("telescope.actions")

    local config = {
      defaults = {
        file_ignore_patterns = {
          '.git',
          '^node_modules',
        },
        mappings = {
          i = {
            ['<esc>'] = function(bufnr)
              telescope_actions.close(bufnr)
            end,
          },
        },
      },
    }

    telescope.setup(config)

    vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
    vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers)
    vim.keymap.set('n', '<leader>fl', telescope_builtin.lsp_document_symbols)
    vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)

    -- FIXME
    -- vim.keymap.set('n', '<leader>fe', telescope.extensions.file_browser.file_browser)

    -- FIXME:
    -- vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>')

  end
}
