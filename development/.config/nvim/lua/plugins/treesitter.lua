-- lua/plugins/treesitter.lua
-- treesitter config

local treesitter_configs = require('nvim-treesitter.configs')

treesitter_configs.setup({
  ensure_installed = {
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'cpp',
    'fish',
    'gdscript',
    'gitignore',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'rust',
  },
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

