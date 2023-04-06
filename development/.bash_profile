#
# ~/.bash_profile
#

if [ -f ~/.bash_aliases ]; then 
    source ~/.bash_aliases 
fi

# TODO: Add special colours when running from
# root
# if [ $(whoami) = 'root' ]; then
# 	echo "You are root"
# else
# 	echo "You are not root"
# fi

# TODO: Add this to your notes
# How to change color of text: \[\e[<ATTR>;<COLOR>m\] 
# >> FG Colors:
#  Black: 30
#   Blue: 34
#   Cyan: 36
#  Green: 32
# Purple: 35
#    Red: 31
#  White: 37
# Yellow: 33
# >> BG Colors: (in separate instruction):
#  Black: 40
#   Blue: 44
#   Cyan: 46
#  Green: 42
# Purple: 45
#    Red: 41
#  White: 47
# Yellow: 43 
# >> Attributes:
#        Normal: 0
# Bold or Light: 1 (depends on terminal emulator)
#           Dim: 2
#     Underline: 4
#      Blinking: 5 (may not work in some terminal emulators)
#      Reversed: 7
#        Hidden: 8

PS1='\n\[\e[1;34m\] \w $ \[\e[0;37m\]'

# Start Xorg Server
if [ $(tty) = "/dev/tty1" ]; then
    exec startx
fi

