return {
  -- LSP
  require("gr3yknigh1.lazy.nvim-lspconfig"),
  require("gr3yknigh1.lazy.williamboman.mason"),
  require("gr3yknigh1.lazy.williamboman.mason-lsp"),

  -- DAP
  {
    'jayp0521/mason-nvim-dap.nvim',
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    }
  },

  -- UI
  require("gr3yknigh1.lazy.neo-tree"),

  -- Tools
  require("gr3yknigh1.lazy.telescope"),

  -- Colors
  {
    "nordtheme/vim",
    name = "nordtheme",
    init = function()
      vim.cmd [[colorscheme nord]]
    end
  },

  -- syntax
  require("gr3yknigh1.lazy.nvim-treesitter"),

  -- etc
  require("gr3yknigh1.lazy.Comment"),
  require("gr3yknigh1.lazy.nvim-surround"),

  -- etc/folke
  { "folke/which-key.nvim" },
  { "folke/neoconf.nvim",  cmd = "Neoconf" },
  {
    "folke/neodev.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
}
