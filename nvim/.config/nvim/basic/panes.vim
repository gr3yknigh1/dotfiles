" --- Panes --- "

set splitbelow
set splitright

nmap <leader>\ :vsplit <CR>
nmap <leader>- :split  <CR>

" Terminal panes
nmap <leader>t\ :vsplit term://$SHELL <CR><S-a>
nmap <leader>t- :split  term://$SHELL <CR><S-a>
tmap <leader><Esc> <c-\><c-n>
autocmd TermOpen * :set nonumber norelativenumber  " Turn off numberlines on terminal open

" Pane scrolling
" nmap <Tab> <C-w>w
" nmap <S-Tab> <C-w>W

" Pane switching
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
