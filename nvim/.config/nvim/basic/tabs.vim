" --- Tabs --- "

nmap <silent> <leader><C-t>   :tabnew      <CR>
nmap <silent> <leader><C-w>   :tabclose    <CR>
nmap <silent> <leader><Tab>   :tabnext     <CR>
nmap <silent> <leader><S-Tab> :tabprevious <CR>

" Terminal tabs
" nmap <silent> <leader>t       :tabnew term://$SHELL<Enter><S-a>

tmap <silent> <leader><Tab>   <leader><ESC>:tabnext     <CR>
tmap <silent> <leader><S-Tab> <leader><ESC>:tabprevious <CR>
tmap <silent> <leader>w       <leader><ESC>:q           <CR>
