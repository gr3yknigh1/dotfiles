" --- GENERAL ---

" lua require('basic')

let g:mapleader="\\"
set listchars=eol:¶,tab:>-,trail:~,extends:>,precedes:<,space:·
" set list

nnoremap <leader>w :set list!<CR>
" inoremap <F5> <C-o>:set list!<CR>
" cnoremap <F5> <C-c>:set list!<CR>map <leader>h :set list

" File formats

syntax enable
filetype plugin indent on
set encoding=utf-8
set fileformat=unix
set wrap

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
Plug 'morhetz/gruvbox'

" Syntaxing & languages
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'khaveesh/vim-fish-syntax'

" Etc
Plug 'editorconfig/editorconfig-vim'
Plug 'numToStr/Comment.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


" --- Apperience ---

colorscheme gruvbox

" --- PLUGIN'S CONFIGURATIONS ---

au FileType gitcommit let b:EditorConfig_disable = 1
let g:EditorConfig_exec_path = '/usr/local/editorconfig'
let g:EditorConfig_core_mode = 'external_command'

" -- Telescope

" Find files using Telescope command-line sugar.
nmap <Leader>ff <cmd>Telescope find_files hidden=true<cr>
nmap <Leader>fg <cmd>Telescope live_grep<cr>
nmap <Leader>fb <cmd>Telescope buffers<cr>
nmap <Leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
local actions = require("telescope.actions")
require('telescope').setup{
    defaults = {
        file_ignore_patterns = { "**/.git/", "**/node_modules/", "**/.mono/", "**/.import/" },
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        }
    }
}
EOF

" -- NERDTree

let NERDTreeShowHidden=1
nmap <C-b> :NERDTreeToggle <Enter>

" -- COC

" goto definition

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
" open definition in a split window

let g:coc_global_extensions = ['coc-json', 'coc-git']
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <leader>dy :CocCommand yank.clean<cr>

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
nmap <Leader>t :tabnew term://$SHELL<Enter><S-a>
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
nmap <silent><Leader><C-t> :tabnew<Enter>
nmap <silent><Leader><C-w> :tabclose<Enter>
nmap <silent><Leader><Tab> :tabnext<Enter>
nmap <silent><Leader><S-Tab> :tabprevious<Enter>
tmap <silent><Leader><Tab> <leader><ESC>:tabnext<Enter>
tmap <silent><Leader><S-Tab> <leader><ESC>:tabprevious<Enter>

nmap <silent><leader><BS> :bprevious<cr>
nmap <silent><leader><S-BS> :bnext<cr>

nmap <silent><leader><C-d> :bd<cr>

" noh 
nmap <silent><Leader>n :noh<Enter>

" python interpreter
nmap <silent><Leader>i :tabnew term://python3<Enter><S-a>
nmap <silent><Leader>p :tabnew term://python3 %<Enter><S-a>

" lazygit
" nmap <silent> <leader>gg :LazyGit<CR>
" nmap <Leader>l :tabnew term://lazygit<Enter><S-a>

" ranger
" nmap <Leader>r :tabnew term://ranger<Enter><S-a>

" Airline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

