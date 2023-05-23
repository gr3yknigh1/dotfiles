#!/bin/sh
#
# Based on script by z3bra -- 2014-01-21
# Reference:
# https://wiki.vifm.info/index.php?title=How_to_preview_images

w3mimgdisplay='/usr/lib/w3m/w3mimgdisplay'
fonth=15 # Size of one terminal row    in pixels
fontw=8  # Size of one terminal column in pixels

x=$1
y=$2
cols=$3
lines=$4
file=$5

widthheight=$(printf '5;%s' "$file" | "$w3mimgdisplay")
width=${widthheight% *}
height=${widthheight#* }

if [ -z "$width" ] || [ -z "$height" ]; then
    echo 'Failed to obtain image size. Check if fonth and fontw are correct.'
    exit 1
fi

x=$((fontw * x))
y=$((fonth * y))
max_width=$((fontw * cols))
max_height=$((fonth * lines))

if [ "$width" -gt "$max_width" ]; then
    height=$((height * max_width / width))
    width=$max_width
fi
if [ "$height" -gt "$max_height" ]; then
    width=$((width * max_height / height))
    height=$max_height
fi

printf '0;1;%s;%s;%s;%s;;;;;%s\n4;\n3;' "$x" "$y" "$width" "$height" "$file" | 
    "$w3mimgdisplay"
