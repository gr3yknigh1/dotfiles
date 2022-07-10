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

" Puml
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
call plug#end()


" --- Apperience ---

colorscheme nord

" --- PLUGIN'S CONFIGURATIONS ---

au FileType gitcommit let b:EditorConfig_disable = 1
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
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
        file_ignore_patterns = { ".git", "node_modules", ".mono", ".import" },
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--ignore-file',
          '.gitignore'
        },
    }
}
EOF

" -- NERDTree

let NERDTreeShowHidden=1
nnoremap <leader><Space> :NERDTreeToggle<cr>
nnoremap <leader>r :NERDTreeRefreshRoot<cr>
nnoremap <C-f> :NERDTreeFind<CR>

let g:NERDTreeIgnore = ['.git', "^.import", ".mono"]

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

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

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yank']
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
tmap <silent><leader>w <leader><esc>:q<cr>

nmap <silent><leader><BS> :bprevious<cr>
nmap <silent><leader><S-BS> :bnext<cr>

nmap <silent><leader><C-d> :bd<cr>

" noh 
nmap <silent><Leader>n :noh<Enter>

" python interpreter
nmap <silent><Leader>I :tabnew term://python3<Enter><S-a>
nmap <silent><Leader>P :tabnew term://python3 %<Enter><S-a>
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

xnoremap d "_d
vnoremap d "_d
nnoremap d "_d
