"
" .vimrc
" 
" My simple vim configuration.
"

let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_liststyle = 3

if (has("termguicolors"))
    syntax on
    set termguicolors
endif

if has("gui_running")
    syntax on

    "
    " NOTE(gr3yknigh1): Tried to keep font size and font name as separate
    " variables but because of shitty API that VIM is provided, you can't have
    " spaces in the name of the font. I have tried to replace " " with "\ ",
    " but in only works in literals. So it's can't be done programmaticly in the
    " function.
    "
    " Here the old implementation:
    "
    "     let g:gui_fontname = "Inconsolata\ Nerd\ Font\ Mono"
    "     let g:gui_fontname = "Consolas"
    "
    "     function GUI_SetFont(fontname, fontsize)
    "         " This is doesn't work for font names with spaces.
    "         let l:fontname = substitute(a:fontname, " ", "\\ ", "g") 
    "         echom "set guifont=" . l:fontname . ":h" . a:fontsize
    "         execute "set guifont=" . a:fontname . ":h" . a:fontsize
    "     endfunction
    "
    "     function GUI_IncreaseFontSize()
    "         let g:gui_fontsize = g:gui_fontsize + 1
    "         call GUI_SetFont(g:gui_fontname, g:gui_fontsize)
    "     endfunction
    "
    "     function GUI_DecreaseFontSize()
    "         let g:gui_fontsize = g:gui_fontsize - 1
    "         call GUI_SetFont(g:gui_fontname, g:gui_fontsize)
    "     endfunction
    "
    "

    " Thanks: <https://vi.stackexchange.com/a/3104>
    
    let &guifont="Inconsolata\ Nerd\ Font\ Mono:h20"

    function GUI_IncreaseFontSize()
        let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
        let l:gf_size_whole = l:gf_size_whole + 1
        let l:new_font_size = ':h'.l:gf_size_whole
        let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function GUI_DecreaseFontSize()
        let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
        let l:gf_size_whole = l:gf_size_whole - 1
        let l:new_font_size = ':h'.l:gf_size_whole
        let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    colorscheme elflord

    "
    " if has("gui_running")
    "   if has("gui_gtk2")
    "     set guifont=Inconsolata\ 12
    "   elseif has("gui_macvim")
    "     set guifont=Menlo\ Regular:h14
    "   elseif has("gui_win32")
    "     set guifont=Consolas:h13:cANSI
    "   endif
    " endif
    "

    nmap <silent> <C-kPlus> <cmd>call GUI_IncreaseFontSize()<CR>
    nmap <silent> <C-kMinus> <cmd>call GUI_DecreaseFontSize()<CR>

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

    " Making backspace working on Windows.
    set backspace=indent,eol,start
endif

if has("unix")
    set fileformat=unix

    set clipboard^=unnamedplus
endif


"""""""""""""""""""""""""""""""""""""""""""""""" Functions """"""""""""""""""""""""""""""""""""""""""""""""""""""""


if has("win32")
    let g:os_path_sep = "\\"
endif

if has("unix")
    let g:os_path_sep = "/"
endif


function FileSystem_JoinPath(pathA, pathB)
    return a:pathA . g:os_path_sep . a:pathB
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""" Autocommands """"""""""""""""""""""""""""""""""""""""""""""""""""""""


let g:buildsystem_win32_buildscript_name   = "build.bat"
let g:buildsystem_win32_remedybg_exename   = "remedybg.exe"
let g:buildsystem_win32_remedybg_extension = "rdbg"

function BuildSystem_Win32_BuildBat(root)
    if !isdirectory(a:root)
        throw "Invalid argument: root isn't directory"
    endif

    let build_script = FileSystem_JoinPath(a:root, g:buildsystem_win32_buildscript_name)
    execute '!' "start " . build_script 
endfunction

function BuildSystem_Win32_RunRemedyBG(root, remedybg, config)
    if !isdirectory(a:root)
        throw "Invalid argument: root isn't directory"
    endif

    if !executable(a:remedybg)
        throw "Invalid argument: not an executable"
    endif

    if !filereadable(a:config)
        throw "Invalid argument: invalid config"
    endif

    execute '!' "start cmd /c " .  a:remedybg . ' -g -q ' . a:config
endfunction

au VimEnter *        call BuildSystem_SetKeybindings()
au DirChanged global call BuildSystem_SetKeybindings()
function BuildSystem_SetKeybindings()

    let g:buildsystem_srcroot = getcwd()

    if has("win32") && filereadable(FileSystem_JoinPath(g:buildsystem_srcroot, g:buildsystem_win32_buildscript_name))
        nmap <leader>b <cmd>call BuildSystem_Win32_BuildBat(g:buildsystem_srcroot)<CR>
    endif

    if has("win32") && executable(g:buildsystem_win32_remedybg_exename)
        for item in glob(g:buildsystem_srcroot . g:os_path_sep . "*." . g:buildsystem_win32_remedybg_extension, 1, 1)
            if !filereadable(item)
                continue
            endif

            let g:buildsystem_win32_remedybg_config = item
            nmap <leader>dr <cmd>call BuildSystem_Win32_RunRemedyBG(g:buildsystem_srcroot, g:buildsystem_win32_remedybg_exename, g:buildsystem_win32_remedybg_config)<CR>
            break " TODO(ilya): Add input option in choosing of remedybg's config
        endfor
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""" Settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8
filetype on
filetype plugin on
filetype indent on

set belloff=all
set noerrorbells
set vb t_vb=

set mouse=a

let c_syntax_for_h=1

set colorcolumn=120

" au FileType c

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

""""""""""""""""""""""""""""""""""""""""" Keyboard mappings """""""""""""""""""""""""""""""""""""""""

" File explorer
nmap <silent> <leader><Esc> <cmd>Rex<CR>

" Saving
nmap <silent> <C-s>     <cmd>w<CR>
nmap <silent> <leader>s <cmd>wa<CR>

" Extra symbols
nmap <silent> <leader>h <cmd>noh<CR>
nmap <silent> <leader>R :set list!<CR>

" Pane splitting
nmap <silent> <leader>\ :vsplit <CR>
nmap <silent> <leader>- :split  <CR>

" Pane switching
nmap <silent> <A-j> <C-W>j
nmap <silent> <A-k> <C-W>k
nmap <silent> <A-h> <C-W>h
nmap <silent> <A-l> <C-W>l

" Pane resize
" TODO(ilya.a): Checkout why it's doesn't work on the Windows [2024/06/08]
nmap <C-A-j> 2<C-W>+
nmap <C-A-k> 2<C-W>-
nmap <C-A-h> 2<C-W>>
nmap <C-A-l> 2<C-W><

" Append new lines
nmap <silent> mm o<Esc>k
nmap <silent> MM O<Esc>j

" Tab managment
nmap <silent> <leader><C-t> <cmd>tabnew<CR>
nmap <silent> <leader><C-w> <cmd>tabclose<CR>
nmap <silent> <leader><Tab> <cmd>tabnext<CR>
nmap <silent> <leader><S-Tab> <cmd>tabprevious<CR>

" Buffer management
nnoremap <silent> <A-,>  <cmd>bprevious<CR>
nnoremap <silent> <A-.>  <cmd>bnext<CR>
nnoremap <silent> <leader><C-d> <cmd>bdelete<CR>

" Macros
imap <silent> <C-t> TODO(ilya.a): 
imap <silent> <C-o> NOTE(ilya.a): 

" Easy
nnoremap ; :

