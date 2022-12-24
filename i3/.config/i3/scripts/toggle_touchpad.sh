#!/bin/bash

device="Synaptics TM3336-004"
prop="Device Enabled"

if xinput list | grep "$device" ; then
    if xinput list-props "$device" | grep "$prop.*1\$" ; then
        xinput set-prop "$device" "$prop" 0
    else
        xinput set-prop "$device" "$prop" 1
    fi
else
    echo "Error to find touchpad with name $device" >> ~/.local/toggle_touchpad.log
fi
