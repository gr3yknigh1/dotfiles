" Change these as desired
nnoremap <buffer> <leader>aa <cmd>ArduinoAttach<CR>
nnoremap <buffer> <leader>ai <cmd>ArduinoInfo<CR>
nnoremap <buffer> <leader>av <cmd>ArduinoVerify<CR>
nnoremap <buffer> <leader>au <cmd>ArduinoUpload<CR>
nnoremap <buffer> <leader>as <cmd>ArduinoSerial<CR>
" nnoremap <buffer> <leader>ad <cmd>ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>

" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
" function! ArduinoStatusLine()
"   let port = arduino#GetPort()
"   let line = '[' . g:arduino_board . '] [' . g:arduino_programmer . ']'
"   if !empty(port)
"     let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
"   endif
"   return line
" endfunction
"
" augroup ArduinoStatusLine
"   autocmd! * <buffer>
"   autocmd BufWinEnter <buffer> setlocal stl=%f\ %h%w%m%r\ %{ArduinoStatusLine()}\ %=\ %(%l,%c%V\ %=\ %P%)
" augroup END
"
" autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{MyStatusLine()}'
