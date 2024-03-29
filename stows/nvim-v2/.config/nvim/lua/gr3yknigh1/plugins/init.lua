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
  require("gr3yknigh1.plugins.lewis6991.gitsigns"),
  require("gr3yknigh1.plugins.phaazon.hop"),
  require("gr3yknigh1.plugins.kdheepak.lazygit"),
  require("gr3yknigh1.plugins.RaafatTurki.hex"),
  require("gr3yknigh1.plugins.telescope"),


  -- Colors
  {
    "nordtheme/vim",
    name = "nordtheme",
    init = function()
      -- vim.cmd [[colorscheme nord]]
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    init = function()
      -- vim.o.background = "light"
      -- vim.cmd([[colorscheme gruvbox]])
    end
  },
  {
    "ARivottiC/rivotti256.vim",
    init = function ()
      -- vim.cmd([[colorscheme rivotti256]])
    end
  },
  {
    "zefei/simple-dark",
    init = function ()
      -- vim.cmd([[colorscheme simple-dark]])
    end
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = 'darker',
    },
    init = function ()
      vim.cmd([[colorscheme onedark]])
    end,
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
  require("gr3yknigh1.plugins.folke.neodev"),
}
