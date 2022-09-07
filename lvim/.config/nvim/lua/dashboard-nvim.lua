-- @gr3yknigh1
-- 2022
-- 
-- https://github.com/glepnir/dashboard-nvim


local db = require('dashboard')
local home = os.getenv('HOME')

db.default_banner = {
'',
' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
'',
' [ TIP: To exit Neovim, just power off your computer. ] ',
'',
}

db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
  {
    icon = '  ',
    desc = 'Recent sessions',
    shortcut = '',
    action ='SessionLoad'
  },
}
db.custom_footer = { '', 'Join cult of vim, brother' }
db.session_directory = "~/.config/nvim/session"

