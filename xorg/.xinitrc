feh --no-fehbg --bg-fill ~/.dotfiles/wallpapers/dark-blue-gradient.jpg

setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'

udiskie &
picom &

exec i3
