" --- Init --- "

let g:mapleader = "\\"
set nocompatible

source basic/basic.vim
source plugins/plugins.vim

source basic/apperience.vim
source basic/rendering.vim
source basic/tabs.vim
source basic/panes.vim
source basic/buffers.vim

source plugins/airline.vim
source plugins/coc.vim
source plugins/comment.vim
source plugins/editorconfig.vim
source plugins/NERDTree.vim
source plugins/telescope.vim


nmap <silent><Leader>I :tabnew term://python3<Enter><S-a>
nmap <silent><Leader>P :tabnew term://python3 %<Enter><S-a>

