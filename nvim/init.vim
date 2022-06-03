" --- GENERAL ---

" File formats

syntax enable
filetype plugin indent on
set encoding=utf-8
set fileformat=unix

" Mouse

set mouse=a

" Tabs

set expandtab
set tabstop=4
retab
set shiftwidth=4
set autoindent

set scrolloff=7

" View

set nowrap

set nocompatible

" Splitting

set splitbelow
set splitright

" Line numbers

set relativenumber
set rnu


" --- PLUGINS ---


call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/vim-clap'

" Telescope

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

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
Plug 'numToStr/Comment.nvim'
Plug 'khaveesh/vim-fish-syntax'

call plug#end()


" --- Apperience ---


colorscheme gruvbox


" --- PLUGIN'S CONFIGURATIONS ---

" -- Telescope

" Find files using Telescope command-line sugar.
nmap <Space>ff <cmd>Telescope find_files<cr>
nmap <Space>fg <cmd>Telescope live_grep<cr>
nmap <Space>fb <cmd>Telescope buffers<cr>
nmap <Space>fh <cmd>Telescope help_tags<cr>

" -- NERDTree

let NERDTreeShowHidden=1
nmap <C-b> :NERDTreeToggle <Enter>

" -- COC

" goto definition

nmap <silent> gd <Plug>(coc-definition)

" Symbol renaming.
nmap <Space>rn <Plug>(coc-rename)

" open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L

let g:coc_global_extensions = ['coc-json', 'coc-git']


" -- Comment

lua << EOF
require('Comment').setup()
EOF

" --- KEYBINDINGS ---


" Terminal splitting
nmap <C-t><C-x> :sp term://$SHELL <Enter>
nmap <C-t><C-y> :vsp term://$SHELL <Enter>
tnoremap <ESC> <c-\><c-n>
autocmd TermOpen * :set nonumber norelativenumber

" Pane scrolling
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w>W

" Pane resizing
nnoremap <silent><Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent><Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

set winminwidth=0
nmap <Leader><C-h> <C-W>h500<C-W>>             
nmap <Leader><C-l> <C-W>l500<C-W>>

" Pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" copy and paste
vmap <C-y> "+y

let g:mapleader="\<Space>"
" let g:dashboard_default_executive = 'clap'
" nmap <Leader>ss :<C-u>SessionSave<CR>
" nmap <Leader>sl :<C-u>SessionLoad<CR>
" nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
" nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
" nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
" nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
" nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
" nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
