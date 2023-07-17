

if (has("termguicolors"))
    syntax on
    set termguicolors
    colorscheme base16-gruvbox-dark-medium
endif

set encoding=utf-8
set fileformat=unix
filetype on
filetype plugin on
filetype indent on

set mouse=a
set colorcolumn=80

set number
set numberwidth=2
set relativenumber
set cursorline
set colorcolumn="80"

set wrap
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
nmap <leader>R :set list!<CR>

nmap <leader>\ :vsplit <CR>
nmap <leader>- :split  <CR>

nmap <A-j> <C-W>j
nmap <A-k> <C-W>k
nmap <A-h> <C-W>h
nmap <A-l> <C-W>l

nmap <C-A-j> 2<C-W>+
nmap <C-A-k> 2<C-W>-
nmap <C-A-h> 2<C-W>>
nmap <C-A-l> 2<C-W><

nnoremap <silent> <A-,>  <cmd>bprevious<CR>
nnoremap <silent> <A-.>  <cmd>bnext<CR>
nnoremap <silent> <leader><C-d> <cmd>bdelete<CR>

" NOTE Thanks TJ
nnoremap <Up>          :echom "--> k <-- "<CR>
nnoremap <Down>        :echom "--> j <-- "<CR>
nnoremap <Right>       :echom "--> l <-- "<CR>
nnoremap <Left>        :echom "--> h <-- "<CR>

inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

nnoremap ; :

