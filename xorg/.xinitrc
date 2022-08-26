source ~/.wallpaper

setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'

polybar & 
udiskie &
picom &

xinput set-prop Synaptics\ TM3336-004 libinput\ Tapping\ Enabled 1
xinput set-prop Synaptics\ TM3336-004 libinput\ Natural\ Scrolling\ Enabled 1

exec i3
