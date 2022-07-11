" --- Init --- "

let g:mapleader = "\\"
set nocompatible


source ~/.config/nvim/basic/basic.vim
source ~/.config/nvim/plugins/plugins.vim

source ~/.config/nvim/basic/apperience.vim
source ~/.config/nvim/basic/rendering.vim
source ~/.config/nvim/basic/tabs.vim
source ~/.config/nvim/basic/panes.vim
source ~/.config/nvim/basic/buffers.vim

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/comment.vim
source ~/.config/nvim/plugins/editorconfig.vim
source ~/.config/nvim/plugins/NERDTree.vim
source ~/.config/nvim/plugins/telescope.vim


nmap <silent><Leader>I :tabnew term://python3<Enter><S-a>
nmap <silent><Leader>P :tabnew term://python3 %<Enter><S-a>

