call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/vim-clap'

" Telescope

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

" Nerdtree

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Colorschemes

Plug 'jonathanfilip/vim-lucius'
Plug 'morhetz/gruvbox'
Plug 'Badacadabra/vim-archery'
Plug 'agude/vim-eldar'
Plug 'arcticicestudio/nord-vim'

" Syntaxing & languages
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'khaveesh/vim-fish-syntax'
Plug 'numToStr/Comment.nvim'

" Etc
Plug 'editorconfig/editorconfig-vim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Puml
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'

call plug#end()
