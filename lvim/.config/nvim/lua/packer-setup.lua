-- @gr3yknigh1
-- 2022
--
-- Packer setup


local ensure_packer = function()
  local fn = vim.fn
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  -- Colorschemes
  use "Mofiqul/dracula.nvim"
  -- use "shaunsingh/nord.nvim"
  use 'arcticicestudio/nord-vim'

  -- LSP
  use "neovim/nvim-lspconfig"

  use "tpope/vim-fugitive"

  -- Syntax (Treesitter)
  use 'nvim-treesitter/nvim-treesitter'
  use "p00f/nvim-ts-rainbow"
  use "lukas-reineke/indent-blankline.nvim"

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippets

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Commenting
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Tools
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }

  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'romgrk/barbar.nvim'
  use 'gpanders/editorconfig.nvim'

  -- Etc
  use 'glepnir/dashboard-nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)

