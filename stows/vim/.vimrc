
if (has("termguicolors"))
    syntax on
    set termguicolors
endif

if has("gui_running")
    syntax on
    set guifont=Consolas:h16
    colorscheme koehler

    set guioptions-=m  " Menu bar
    set guioptions-=T  " Toolbar
    set guioptions-=r  " Right scrollbar always
    set guioptions-=R  " Right scrollbar when splits
    set guioptions-=l  " Left scrollbar always
    set guioptions-=L  " Left scrollbar when splits
    set guioptions-=b  " Bottom scrollbar
endif

if has("win32")
    set fileformat=dos

    " This should work on Windows only.
    "
    " Source: https://stackoverflow.com/questions/8757395/can-vim-use-the-system-clipboards-by-default
    set clipboard=unnamed
endif

if has("unix")
    set fileformat=unix
endif

set encoding=utf-8
filetype on
filetype plugin on
filetype indent on

set mouse=a
set colorcolumn=80,120

set number
set numberwidth=2
set relativenumber

set nowrap
set scrolloff=5

retab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab

set listchars=eol:¶,tab:>-,trail:~,extends:>,precedes:<,space:·
set nolist

set splitbelow
set splitright

let g:mapleader = "\\"

nmap <silent> <C-s> <cmd>w<CR>
nmap <silent> <leader>h <cmd>noh<CR>
nmap <silent> <leader>R :set list!<CR>

nmap <silent> <leader>\ :vsplit <CR>
nmap <silent> <leader>- :split  <CR>

nmap <silent> <A-j> <C-W>j
nmap <silent> <A-k> <C-W>k
nmap <silent> <A-h> <C-W>h
nmap <silent> <A-l> <C-W>l

nmap <C-A-j> 2<C-W>+
nmap <C-A-k> 2<C-W>-
nmap <C-A-h> 2<C-W>>
nmap <C-A-l> 2<C-W><

nnoremap <silent> <A-,>  <cmd>bprevious<CR>
nnoremap <silent> <A-.>  <cmd>bnext<CR>
nnoremap <silent> <leader><C-d> <cmd>bdelete<CR>


imap <silent> <C-t> TODO(ilya.a): 
imap <silent> <C-o> NOTE(ilya.a): 

nnoremap ; :

set belloff=all
set noerrorbells
set vb t_vb=

" Making backspace working on Windows.
set backspace=indent,eol,start
