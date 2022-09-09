
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c",
    "c_sharp",
    "cmake",
    "comment",
    "cpp",
    "dockerfile",
    "elixir",
    "fish",
    "gdscript",
    "gitignore",
    "go",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "pascal",
    "python",
    "regex",
    "rust",
    "solidity",
    "svelte",
    "todotxt",
    "toml",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
