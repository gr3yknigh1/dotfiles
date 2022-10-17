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
