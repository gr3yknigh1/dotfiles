set mouse=a

set expandtab
set tabstop=4
retab
set shiftwidth=4
set autoindent

set scrolloff=7

set fileformat=unix

set nowrap
set encoding=utf-8

set nocompatible

" copy and paste
vmap <C-y> "+y

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

" Etc
Plug 'editorconfig/editorconfig-vim'

call plug#end()

colorscheme eldar

let NERDTreeShowHidden=1

" Keybindings
nmap <C-t><C-x> :sp term://bash <Enter>
nmap <C-t><C-y> :vsp term://bash <Enter>
tnoremap <ESC> <c-\><c-n>
autocmd TermOpen * :set nonumber norelativenumber

" Nerdtree mapping
nmap <C-b> :NERDTreeToggle <Enter>

set splitbelow
set splitright

" Numbers (relative)
set relativenumber
set rnu

nmap <Tab> <C-w>w
nmap <S-Tab> <C-w>W

nnoremap <silent><Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent><Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
