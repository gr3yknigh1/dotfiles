return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdateSync",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        disable = {},
      },
      additional_vim_regex_highlighting = true,
      indent = {
        enable = true
      },
    })
  end
}
