" -- Coc

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gv <cmd>vsp<CR><Plug>(coc-definition)<C-w>L

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Symbol renaming.
nmap <silent> <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yank']

nmap <silent> <leader>y <cmd><C-u>CocList -A --normal yank<cr>
nnoremap <silent> <leader>dy <cmd>CocCommand yank.clean<cr>

