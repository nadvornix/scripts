#!/bin/bash
batperc=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | tr -d -c 0-9`
if [[ $batperc < 82 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
fi
