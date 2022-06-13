" --- GENERAL ---

let g:mapleader="\\"

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

" Apperience

Plug 'jonathanfilip/vim-lucius'
Plug 'morhetz/gruvbox'
Plug 'Badacadabra/vim-archery'
Plug 'agude/vim-eldar'
Plug 'arcticicestudio/nord-vim'

" Syntaxing & languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'khaveesh/vim-fish-syntax'

" Etc
Plug 'editorconfig/editorconfig-vim'
Plug 'numToStr/Comment.nvim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


" --- Apperience ---

colorscheme nord

" --- PLUGIN'S CONFIGURATIONS ---

" -- Telescope

" Find files using Telescope command-line sugar.
nmap <Leader>ff <cmd>Telescope find_files hidden=true<cr>
nmap <Leader>fg <cmd>Telescope live_grep<cr>
nmap <Leader>fb <cmd>Telescope buffers<cr>
nmap <Leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup{
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/" },
    }
}
EOF

" -- NERDTree

let NERDTreeShowHidden=1
nmap <C-b> :NERDTreeToggle <Enter>

" -- COC

" goto definition

nmap <silent>gd <Plug>(coc-definition)

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

" open definition in a split window
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L

let g:coc_global_extensions = ['coc-json', 'coc-git']


" -- Comment

lua << EOF
require('Comment').setup()
EOF

" --- KEYBINDINGS ---

" Window splitting

nmap <Leader>\ :vsplit<Enter>
nmap <Leader>- :split<Enter>

" Terminal splitting
nmap <C-t>\ :vsplit term://$SHELL <Enter><S-a>
nmap <C-t>- :split term://$SHELL <Enter><S-a>
tmap <Leader><ESC> <c-\><c-n>
nmap <Leader><C-t> :tabnew term://$SHELL<Enter><S-a>
autocmd TermOpen * :set nonumber norelativenumber 

" Pane scrolling
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w>W

" Pane resizing
"nnoremap <silent><Leader>+ :exe resize  . (winheight(0) * 3/2)<CR>
"nnoremap <silent><Leader>- :exe resize  . (winheight(0) * 2/3)<CR>
"nnoremap <silent><Leader>> :exe vertical resize  . (winwidth(0) * 3/2)<CR>
"nnoremap <silent><Leader>< :exe vertical resize  . (winwidth(0) * 2/3)<CR>

set winminwidth=0
nmap <Leader><C-h> <C-W>h500<C-W>>             
nmap <Leader><C-l> <C-W>l500<C-W>>

" Pane switching
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" copy and paste
xnoremap p pgvy
vmap <C-y> "+y
nmap <C-p> "+p

" tabs
nmap <silent><Leader>t :tabnew<Enter>
nmap <silent><Leader>w :tabclose<Enter>
nmap <silent><Leader><Tab> :tabnext<Enter>
nmap <silent><Leader><S-Tab> :tabprevious<Enter>

" noh 
nmap <silent><Leader>h :noh<Enter>

" python interpreter
nmap <silent><Leader>i :tabnew term://python3<Enter><S-a>
nmap <silent><Leader>r :tabnew term://python3 %<Enter><S-a>

" lazygit
" nmap <silent> <leader>gg :LazyGit<CR>
nmap <Leader>g :tabnew term://lazygit<Enter><S-a>


" Airline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" let g:airline_theme='nord_minimal'


