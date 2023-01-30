#!/bin/bash
if [ $# -ge 1 ]; then
	xrandr --output $1 --auto --right-of LVDS1 --mode 1920x1080
else
	DP=$(xrandr | grep " connected " | awk '{ print$1 }')
	DP=${DP//LVDS1/}
	if [ -n $DP ]; then
		xrandr --output $DP --auto --right-of LVDS1 --mode 2560x1440 --rate 30
	fi
fi
xsetwacom set "Wacom ISDv4 E6 Pen stylus" MapToOutput LVDS1
xsetwacom set "Wacom ISDv4 E6 Pen eraser" MapToOutput LVDS1
xsetwacom set "Wacom ISDv4 E6 Finger touch" MapToOutput LVDS1
feh --bg-scale ~/Bilder/bg_hori.jpg --bg-scale ~/Bilder/bg_hori.jpg &
