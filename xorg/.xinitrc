source ~/.wallpaper

setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'

polybar & 
udiskie &
picom &

xinput set-prop 11 299 1
xinput set-prop 11 276 1

exec i3
