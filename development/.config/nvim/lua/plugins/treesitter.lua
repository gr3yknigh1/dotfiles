-- Treesitter

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c",
    "c_sharp",
    "cmake",
    "comment",
    "cpp",
    "fish",
    "gdscript",
    "gitignore",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
  },
  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local tconfigs = require("nvim-treesitter.configs")

tconfigs.setup({
  highlight = {
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
})
