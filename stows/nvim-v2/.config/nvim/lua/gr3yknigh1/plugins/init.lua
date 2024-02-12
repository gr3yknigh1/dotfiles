return {
  -- LSP
  require("gr3yknigh1.plugins.nvim-lspconfig"),
  require("gr3yknigh1.plugins.nvim-cmp"),
  require("gr3yknigh1.plugins.williamboman.mason"),
  require("gr3yknigh1.plugins.williamboman.mason-lsp"),

  -- DAP
  -- FIXME:
  -- {
  --   'jayp0521/mason-nvim-dap.nvim',
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "mfussenegger/nvim-dap",
  --   }
  -- },

  -- UI
  require("gr3yknigh1.plugins.neo-tree"),
  require("gr3yknigh1.plugins.lualine"),
  require("gr3yknigh1.plugins.ibl"),

  -- Tools
  require("gr3yknigh1.plugins.telescope"),

  -- Colors
  {
    "nordtheme/vim",
    name = "nordtheme",
    init = function()
      vim.cmd [[colorscheme nord]]
    end
  },

  -- Syntax
  require("gr3yknigh1.plugins.nvim-treesitter"),
  require("gr3yknigh1.plugins.nvim-tree-docs"),
  require("gr3yknigh1.plugins.nvim-treesitter-textobjects"),

  -- Etc
  require("gr3yknigh1.plugins.Comment"),
  require("gr3yknigh1.plugins.nvim-surround"),
  require("gr3yknigh1.plugins.nvim-autopairs"),

  { "folke/which-key.nvim" },
  { "folke/neoconf.nvim",  cmd = "Neoconf" },
  {
    "folke/neodev.nvim",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
}
