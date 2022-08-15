" -- Keybindings

" Quitting
nmap <silent> <leader>q <cmd>q<CR>
tmap <silent> <leader>q <cmd>q<CR>
nmap <silent> <leader>Q <cmd>qa<CR>
tmap <silent> <leader>Q <cmd>qa<CR>

" Saving
nmap <silent> <C-s> <cmd>w<CR>

" Tabbing in Insert mode

" Copy & Paste
xnoremap p     pgvy
vmap     <C-y> "+y
nmap     <C-p> "+p

" Deleting
" xnoremap d "_d
" vnoremap d "_d
" noremap d  "_d
" nmap dd Vd<CR>
" vmap d Vd<CR>

" No search highlight
nmap <silent> <leader>h <cmd>noh<CR>

" Toggle whitespace
nmap <leader>R :set list!<CR>

" Tabs
nmap <silent> <leader>t <cmd>tabnew     <CR>
nmap <silent> <leader>w <cmd>tabclose   <CR>
nmap <silent> <Tab>     <cmd>tabnext    <CR>
nmap <silent> <S-Tab>   <cmd>tabprevious<CR>

" Terminal tabs
nmap <silent> <leader>tt       :term<CR>i
tmap <silent> <leader><Tab>    <leader><ESC>:tabnext<CR>
tmap <silent> <leader><S-Tab>  <leader><ESC>:tabprevious<CR>
tmap <silent> <leader><C-w>    <cmd>exit<CR>

" Terminal panes
" nnoremap <leader>t\ :vsplit term://$SHELL <CR>
" nnoremap <leader>t- :split  term://$SHELL <CR>


" -- Pane splitting
nmap <leader>\ :vsplit <CR>
nmap <leader>- :split  <CR>

" Escape terminal
tnoremap <leader><Esc> <C-\><C-n>

" Open in terminal (Tabbed)
" nnoremap <leader>O :tabnew term://
" nnoremap <leader>o- :sp term://

" Run programms
" nnoremap <leader>I <cmd>tabnew term://python3<CR>
" nnoremap <leader>P <cmd>tabnew term://python3 %<CR>
" nnoremap <leader>R <cmd>tabnew term://rustc % -o /tmp/a.out && /tmp/a.out<CR>
" nnoremap <leader>p :tabnew term://python3 

" Config editting
" nmap <leader><C-A-r> <cmd>source $MYVIMRC<CR>
" nmap <leader><C-A-e> <cmd>edit   $MYVIMRC<CR>
" noremap <leader><C-A-e>\ <cmd>vsplit $MYVIMRC<CR>
