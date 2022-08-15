
source ~/.config/nvim/basic.vim
source ~/.config/nvim/keybindings.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/colortheme.vim


" Com

" let g:python3_executable = "python"
"
" function RunPythonScript(file)
"     execute "!" . g:python3_executable . " " . a:file
" endfunction
"
" function SourceVimScript(file)
"     source a:file
" endfunction
"
" function CompileCommand()
"     let l:filetype = &filetype
"     let l:path = expand('%:p')
"
"     if l:filetype == "vim"
"         echo "error: can't compile vim"
"     elseif l:filetype == "python"
"         echo "error: you can't compile python idiot"
"     endif
" endfunction
"
" function RunCommand()
"     let l:filetype = &filetype
"     let l:path = expand('%:p')
"     
"     if l:filetype == "python"
"         call RunPythonScript(l:path)
"     elseif l:filetype == "vim"
"         call SourceVimScript(l:path)
"     else
"         echo "error: filetype doesn't support"
"     endif
"
" endfunction
"
" command -nargs=0 Compile call CompileCommand()
" command -nargs=0 Run     call RunCommand(<args>)
"
