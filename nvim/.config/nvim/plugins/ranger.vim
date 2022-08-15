"  -- Ranger 
"
"  List of commands:
"
"  :Ranger // open current file by default
"  :RangerCurrentFile // Default Ranger behaviour
"  :RangerCurrentDirectory
"  :RangerWorkingDirectory
"
"  // open always in new tabs
"  :RangerNewTab
"  :RangerCurrentFileNewTab
"  :RangerCurrentDirectoryNewTab
"  :RangerWorkingDirectoryNewTab
"
"  // open tab, when existant or in new tab when not existant
"  :RangerCurrentFileExistingOrNewTab
"  :RangerCurrentDirectoryExistingOrNewTab
"  :RangerWorkingDirectoryExistingOrNewTab

noremap <leader>f  <cmd>RangerNewTab<CR>
noremap <leader>f\ <cmd>split<CR><cmd>Ranger<CR>

let g:ranger_command_override = 'ranger'
let g:ranger_replace_netrw = 1 
