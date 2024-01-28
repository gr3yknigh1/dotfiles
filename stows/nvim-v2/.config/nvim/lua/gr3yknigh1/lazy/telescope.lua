
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
  opts = {
    defaults = {
      file_ignore_patterns = {
        '.git',
        '^node_modules',
      },
      mappings = {
        i = {
          ['<esc>'] = function(bufnr)
            require("telescope.actions").close(bufnr)
          end,
        },
      },
    },
  },
  config = function(opts)
    require("telescope").setup(opts)
  end
}
