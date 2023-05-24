" -- NERDTree

let g:NERDTreeHijackNetrw = 0 

let NERDTreeShowHidden=1
nmap <silent> <leader>n <cmd>NERDTreeFocus<CR>
nmap <silent> <leader><space> <cmd>NERDTreeToggle<CR>
" nmap <silent> <C-f> <cmd>NERDTreeFind<CR>
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

