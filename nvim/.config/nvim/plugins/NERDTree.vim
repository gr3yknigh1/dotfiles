" --- Plugins.NERDTree --- "

let NERDTreeShowHidden=1
nmap <silent> <C-b> <cmd>NERDTreeToggle<CR>
nmap <silent> <C-f> <cmd>NERDTreeFind<CR>
" nmap <leader>r :NERDTreeRefreshRoot<cr>

let g:NERDTreeIgnore = ['.git', ".import", ".mono"]

" This fixing brackets around devicons in NERDTree
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
