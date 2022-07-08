# feh --no-fehbg --bg-fill ~/.dotfiles/wallpapers/nature/pexels-michał-osiński-3454270.jpg

setxkbmap -layout us,ru
setxkbmap -option 'grp:win_space_toggle'

touchpad_name="Synaptics TM3336-004"

xinput set-prop $touchpad_name "libinput Tapping Enabled" 1
xinput set-prop $touchpad_name "libinput Natural Scrolling Enabled" 1

udiskie &
dhcpcd &
picom &
