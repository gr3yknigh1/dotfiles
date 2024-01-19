-- lua/plugins/init.lua

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ensure_packer = function()
  local fn = vim.fn

  local packer_script_path = '/site/pack/packer/start/packer.nvim'
  local packer_repo_url = 'https://github.com/wbthomason/packer.nvim'
  local packer_install_path = vim.fn.stdpath('data') .. packer_script_path
  local packer_install_cmd = {
    'git', 'clone', '--depth', '1', packer_repo_url, packer_install_path
  }

  if fn.empty(fn.glob(packer_install_path)) > 0 then
    fn.system(packer_install_cmd)
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Colorschemes
  use 'Mofiqul/dracula.nvim'
  use 'arcticicestudio/nord-vim'
  use 'ellisonleao/gruvbox.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  -- use({
  --   'nvimdev/lspsaga.nvim',
  --   after = 'nvim-lspconfig',
  --   config = function()
  --     require('lspsaga').setup({
  --       lightbulb = {
  --         enable = true,
  --       },
  --     })
  --   end,
  -- })

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jayp0521/mason-nvim-dap.nvim'

  use({
    'https://gitlab.com/itaranto/plantuml.nvim',
    tag = '*',
    config = function()
      require('plantuml').setup()
    end
  })

  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
  use 'theHamsta/nvim-dap-virtual-text'

  use 'nvim-treesitter/nvim-treesitter'
  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'onsails/lspkind.nvim'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'numToStr/Comment.nvim'

  -- Tools
  use {
    'nvim-telescope/telescope.nvim', tag = '*',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'kdheepak/lazygit.nvim'

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- UI
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup(
        {
          -- Options related to LSP progress subsystem
          progress = {
            poll_rate = 0,        -- How and when to poll for progress messages
            suppress_on_insert = false, -- Suppress new messages while in insert mode
            ignore_done_already = false, -- Ignore new tasks that are already complete
            ignore_empty_message = false, -- Ignore new tasks that don't contain a message
            clear_on_detach =     -- Clear notification group when LSP server detaches
                function(client_id)
                  local client = vim.lsp.get_client_by_id(client_id)
                  return client and client.name or nil
                end,
            notification_group = -- How to get a progress message's notification group key
                function(msg) return msg.lsp_client.name end,
            ignore = {}, -- List of LSP servers to ignore

            -- Options related to how LSP progress messages are displayed as notifications
            display = {
              render_limit = 16, -- How many LSP messages to show at once
              done_ttl = 3, -- How long a message should persist after completion
              done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
              done_style = "Constant", -- Highlight group for completed LSP tasks
              progress_ttl = math.huge, -- How long a message should persist when in progress
              progress_icon = -- Icon shown when LSP progress tasks are in progress
              { pattern = "dots", period = 1 },
              progress_style = -- Highlight group for in-progress LSP tasks
              "WarningMsg",
              group_style = "Title", -- Highlight group for group name (LSP server name)
              icon_style = "Question", -- Highlight group for group icons
              priority = 30, -- Ordering priority for LSP notification group
              skip_history = true, -- Whether progress notifications should be omitted from history
              format_message = -- How to format a progress message
                  require("fidget.progress.display").default_format_message,
              format_annote = -- How to format a progress annotation
                  function(msg) return msg.title end,
              format_group_name = -- How to format a progress notification group's name
                  function(group) return tostring(group) end,
              overrides = { -- Override options from the default notification config
                rust_analyzer = { name = "rust-analyzer" },
              },
            },

            -- Options related to Neovim's built-in LSP client
            lsp = {
              progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
            },
          },

          -- Options related to notification subsystem
          notification = {
            poll_rate = 10,       -- How frequently to update and render notifications
            filter = vim.log.levels.INFO, -- Minimum notifications level
            history_size = 128,   -- Number of removed messages to retain in history
            override_vim_notify = false, -- Automatically override vim.notify() with Fidget
            configs =             -- How to configure notification groups when instantiated
            { default = require("fidget.notification").default_config },
            redirect =            -- Conditionally redirect notifications to another backend
                function(msg, level, opts)
                  if opts and opts.on_open then
                    return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
                  end
                end,

            -- Options related to how notifications are rendered as text
            view = {
              stack_upwards = true, -- Display notification items from bottom to top
              icon_separator = " ", -- Separator between group name and icon
              group_separator = "---", -- Separator between notification groups
              group_separator_hl = -- Highlight group used for group separator
              "Comment",
              render_message = -- How to render notification messages
                  function(msg, cnt)
                    return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
                  end,
            },

            -- Options related to the notification window and buffer
            window = {
              normal_hl = "Comment", -- Base highlight group in the notification window
              winblend = 100, -- Background color opacity in the notification window
              border = "none", -- Border around the notification window
              zindex = 45,   -- Stacking priority of the notification window
              max_width = 0, -- Maximum width of the notification window
              max_height = 0, -- Maximum height of the notification window
              x_padding = 1, -- Padding from right edge of window boundary
              y_padding = 0, -- Padding from bottom edge of window boundary
              align = "bottom", -- How to align the notification window
              relative = "editor", -- What the notification window position is relative to
            },
          },

          -- Options related to integrating with other plugins
          integration = {
            ["nvim-tree"] = {
              enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
            },
          },

          -- Options related to logging
          logger = {
            level = vim.log.levels.WARN, -- Minimum logging level
            float_precision = 0.01, -- Limit the number of decimals displayed for floats
            path =               -- Where Fidget writes its logs to
                string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
          },
        }
      )
    end
  }

  -- Etc
  use 'gpanders/editorconfig.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'stevearc/vim-arduino'
  use 'lewis6991/gitsigns.nvim'
  use 'skywind3000/vim-cppman'
  use 'RaafatTurki/hex.nvim'
  use 'moll/vim-bbye'

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup()
    end,
  }

  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use {
    "SmiteshP/nvim-navbuddy",
    requires = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    }
  }

  use 'windwp/nvim-autopairs'

  use { 'kylechui/nvim-surround', tag = '*', }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
