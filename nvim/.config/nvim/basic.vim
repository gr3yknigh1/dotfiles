" -- Basic

if (has("termguicolors"))
  set termguicolors
endif

let g:mapleader = "\\"
set nocompatible
set shell=fish

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

" Line wrapping
set wrap
set scrolloff=7

" Line numbers
set relativenumber
set rnu

autocmd BufEnter *.* set relativenumber
autocmd TermOpen * set nonumber norelativenumber

" Whitespace rendering
set listchars=eol:¶,tab:>-,trail:~,extends:>,precedes:<,space:·
set nolist

" Pane splitting
set splitbelow
set splitright

" Pane focusing
nmap <A-j> <C-W>j
nmap <A-k> <C-W>k
nmap <A-h> <C-W>h
nmap <A-l> <C-W>l

" Pane resize
nmap <C-A-j> 2<C-W>+
nmap <C-A-k> 2<C-W>-
nmap <C-A-h> 2<C-W>>
nmap <C-A-l> 2<C-W>< 

" nmap <C-A-J> 10<C-W>+
" nmap <C-A-K> 10<C-W>-
" nmap <C-A-H> 10<C-W>>
" nmap <C-A-L> 10<C-W>< 

" Terminal pane switching
tmap <A-j> <C-\><C-n><C-W>j
tmap <A-k> <C-\><C-n><C-W>k
tmap <A-h> <C-\><C-n><C-W>h
tmap <A-l> <C-\><C-n><C-W>l

" Terminal autoinsert
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Buffer switching & deleting
nnoremap <silent> <A-,>  <cmd>bprevious<CR>
nnoremap <silent> <A-.>  <cmd>bnext<CR>
nnoremap <silent> <leader><C-d> <cmd>bdelete<CR>
