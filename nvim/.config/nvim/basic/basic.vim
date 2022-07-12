" --- Basic --- "

" File formats
set encoding=utf-8
set fileformat=unix
filetype plugin indent on

" Mouse
set mouse=a

" Tabs
retab
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Syntax
syntax enable

" Copy and paste
xnoremap p     pgvy
vmap     <C-y> "+y
nmap     <C-p> "+p

" Deleting
" xnoremap d "_d
" vnoremap d "_d
" noremap d  "_d
" nmap dd Vd<CR>
" vmap d Vd<CR>

" No search highlight
nmap <silent> <leader>n <cmd>noh<CR>
