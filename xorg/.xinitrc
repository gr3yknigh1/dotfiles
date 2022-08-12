source ~/.wallpaper

setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'

udiskie &
picom &

xinput set-prop 11 284 1
xinput set-prop 11 276 1

exec i3
