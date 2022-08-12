" --- CONFIG --- "

if (has("termguicolors"))
  set termguicolors
endif

let g:mapleader = "\\"
set nocompatible
set shell=fish

nmap <silent> <Leader>q <cmd>quit<CR>
tmap <silent> <Leader>q <cmd>quit<CR>

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

" Tabbing in Insert mode

nmap <C-]> >>
nmap <C-[> V<

" No search highlight
nnoremap <silent> <leader>n <cmd>noh<CR>


" --- Plugins --- "

call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/vim-clap'

" Telescope

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

" Nerdtree

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Colorschemes

Plug 'jonathanfilip/vim-lucius'
Plug 'morhetz/gruvbox'
Plug 'Badacadabra/vim-archery'
Plug 'agude/vim-eldar'
Plug 'arcticicestudio/nord-vim'
Plug 'Mofiqul/dracula.nvim'

" Syntaxing & languages

" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'neovim/nvim-lspconfig'
" Plug 'williamboman/nvim-lsp-installer'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'khaveesh/vim-fish-syntax'
Plug 'numToStr/Comment.nvim'

" Etc
Plug 'editorconfig/editorconfig-vim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Puml
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'

" Ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

call plug#end()


" --- Treesitter

" source ~/.dotfiles/nvim/.config/nvim/treesitter.lua


" --- Apperience --- "

" Syntax
syntax enable

" Colorschemes
colorscheme dracula


" --- Rendering --- "

" Line wrapping
set nowrap
set scrolloff=7

" Line numbers
set relativenumber
set rnu

autocmd BufEnter *.* set relativenumber

" Whitespace rendering
set listchars=eol:¶,tab:>-,trail:~,extends:>,precedes:<,space:·
set nolist
noremap <leader>w :set list!<CR>


" --- Tabs --- "

nnoremap <silent> <Leader><C-t>   <cmd>tabnew      <CR>
nnoremap <silent> <Leader><C-w>   <cmd>tabclose    <CR>
nnoremap <silent> <Leader><Tab>   <cmd>tabnext     <CR>
nnoremap <silent> <Leader><S-Tab> <cmd>tabprevious <CR>

" Terminal tabs
" nmap <silent> <leader>t       :tabnew term://$SHELL<Enter>

tmap <silent> <leader><Tab>   <leader><ESC>:tabnext     <CR>
tmap <silent> <leader><S-Tab> <leader><ESC>:tabprevious <CR>
tmap <silent> <leader><C-w>   <cmd>exit<CR>


" --- Panes --- "

set splitbelow
set splitright

nmap <leader>\ :vsplit <CR>
nmap <leader>- :split  <CR>

" Terminal panes

nnoremap <Leader>t\ :vsplit term://$SHELL <CR>
nnoremap <Leader>t- :split  term://$SHELL <CR>

tnoremap <Leader><Esc> <C-\><C-n>

autocmd TermOpen * :set nonumber norelativenumber

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Pane switching
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-h> <C-W>h
nnoremap <A-l> <C-W>l

nnoremap <C-A-j> 10<C-W>+
nnoremap <C-A-k> 10<C-W>-
nnoremap <C-A-h> 10<C-W>>
nnoremap <C-A-l> 10<C-W><

" Terminal pane switching
tnoremap <A-j> <C-\><C-n><C-W>j
tnoremap <A-k> <C-\><C-n><C-W>k
tnoremap <A-h> <C-\><C-n><C-W>h
tnoremap <A-l> <C-\><C-n><C-W>l


" --- Buffers --- "

nnoremap <silent> <leader><BS>    <cmd>bprevious<CR>
nnoremap <silent> <leader><S-BS>  <cmd>bnext    <CR>
nnoremap <silent> <leader><C-d>   <cmd>bd       <CR>


" --- PLUGINS --- "

" --- Airline --- "

let g:airline_theme="base16_dracula"

let g:airline_experimental = 0
let g:airline_left_sep='>'
let g:airline_right_sep='<'
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 0
let g:airline_detect_spell = 0
let g:airline_detect_spelllang = 0

let g:airline_powerline_fonts = 1

let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ' col:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ' row:'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#tabline#left_alt_sep = ':|:'
let g:airline#extensions#tabline#formatter = 'unique_tail'


" --- COC --- "


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv <cmd>vsp<CR><Plug>(coc-definition)<C-w>L

" Symbol renaming.
nmap <silent> <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yank']

nmap <silent> <leader>y <cmd><C-u>CocList -A --normal yank<cr>
nnoremap <silent> <leader>dy <cmd>CocCommand yank.clean<cr>


" --- Comment --- "

lua << EOF
require('Comment').setup()
EOF


" --- Editorconfig --- "

au FileType gitcommit let b:EditorConfig_disable = 1
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
let g:EditorConfig_core_mode = 'external_command'


" --- NERDTree --- "

let g:NERDTreeHijackNetrw = 0 

let NERDTreeShowHidden=1
nmap <silent> <C-n> <cmd>NERDTreeFocus<CR>
nmap <silent> <C-b> <cmd>NERDTreeToggle<CR>
nmap <silent> <C-f> <cmd>NERDTreeFind<CR>
" nmap <leader>r :NERDTreeRefreshRoot<cr>

let g:NERDTreeIgnore = ['.git', ".import", ".mono"]

" This fixing brackets around devicons in NERDTree
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" --- Git integration
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


" --- Telescope --- "

nmap <leader>ff <cmd>Telescope find_files hidden=true<CR>
nmap <leader>fg <cmd>Telescope live_grep<CR>
nmap <leader>fb <cmd>Telescope buffers<CR>
nmap <leader>fh <cmd>Telescope help_tags<CR>

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


" --- APPLICATIONS --- "

nnoremap <Leader>O :tabnew term://

nnoremap <Leader>I <cmd>tabnew term://python3<CR>
nnoremap <Leader>P <cmd>tabnew term://python3 %<CR>
nnoremap <Leader>R <cmd>tabnew term://rustc % -o /tmp/a.out && /tmp/a.out<CR>
nnoremap <Leader>p :tabnew term://python3 

nmap <Leader><C-A-r> <cmd>source $MYVIMRC<CR>
nmap <Leader><C-A-e> <cmd>edit   $MYVIMRC<CR>
noremap <Leader><C-A-e>\ <cmd>vsplit $MYVIMRC<CR>

"  --- Plug 'francoiscabrol/ranger.vim' --- "
"
"  List of commands:
"
"  :Ranger // open current file by default
"  :RangerCurrentFile // Default Ranger behaviour
"  :RangerCurrentDirectory
"  :RangerWorkingDirectory
"
"  // open always in new tabs
"  :RangerNewTab
"  :RangerCurrentFileNewTab
"  :RangerCurrentDirectoryNewTab
"  :RangerWorkingDirectoryNewTab
"
"  // open tab, when existant or in new tab when not existant
"  :RangerCurrentFileExistingOrNewTab
"  :RangerCurrentDirectoryExistingOrNewTab
"  :RangerWorkingDirectoryExistingOrNewTab

noremap <Leader>f  <cmd>RangerNewTab<CR>
noremap <Leader>f\ <cmd>split<CR><cmd>Ranger<CR>

let g:ranger_command_override = 'ranger'
let g:ranger_replace_netrw = 1 
