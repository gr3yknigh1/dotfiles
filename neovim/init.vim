set nocompatible

call plug#begin('~/.vim/plugged')

" Nerdtree

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Colorthemes

Plug 'jonathanfilip/vim-lucius'
Plug 'morhetz/gruvbox'
Plug 'Badacadabra/vim-archery'
Plug 'agude/vim-eldar'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-git'
Plug 'neoclide/coc-html'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-yaml'
Plug 'fannheyward/coc-markdownlint'
Plug 'fannheyward/coc-rust-analyzer'
Plug 'voldikss/coc-cmake'
Plug 'pappasam/coc-jedi'
Plug 'coc-extensions/coc-omnisharp'

" Etc
Plug 'editorconfig/editorconfig-vim'

call plug#end()

colorscheme eldar

let NERDTreeShowHidden=1

" Tabs
set expandtab
set tabstop=4
retab
set shiftwidth=4

" Keybindings
nmap <C-t><C-x> :sp term://pwsh <Enter>
nmap <C-t><C-y> :vsp term://pwsh <Enter>
tnoremap <ESC> <c-\><c-n>

set splitbelow
set splitright
