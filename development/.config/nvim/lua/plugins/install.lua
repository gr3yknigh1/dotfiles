-- lua/plugins/init.lua
-- packer install pkgs


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

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jayp0521/mason-nvim-dap.nvim'

  use 'mfussenegger/nvim-dap'
  use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'} }
  use 'theHamsta/nvim-dap-virtual-text'

  use 'nvim-treesitter/nvim-treesitter'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

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
  use 'kdheepak/lazygit.nvim'

  -- UI
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-tree.lua'
  -- use {'akinsho/bufferline.nvim', tag = 'v3.*', requires = 'nvim-tree/nvim-web-devicons'}
  use({
    'willothy/nvim-cokeline',
    requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
    config = function()
      require('cokeline').setup()
    end
  })

  -- Etc
  use 'gpanders/editorconfig.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'stevearc/vim-arduino'

  use({
      'kylechui/nvim-surround',
      tag = '*',
      config = function()
          require('nvim-surround').setup({
          })
      end
  })

  if packer_bootstrap then
    require('packer').sync()
  end

end)

