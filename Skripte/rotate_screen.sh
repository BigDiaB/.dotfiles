#!/bin/bash
valuefile="/tmp/screen_rotation.dat"

if [ ! -f "$valuefile" ]; then
	value=0
else
	value=$(cat "$valuefile")
fi
value=$((value + 1))
if [ $value -ge 4 ]; then
	value=0
fi
echo "${value}" > "$valuefile"

if [ $value -eq 0 ] ; then
	eval "xrandr --output LVDS1 --rotate normal"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen stylus' rotate none"
	eval "xsetwacom set 'Wacom ISDv4 E6 Finger touch' rotate none"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen eraser' rotate none"
	feh --bg-scale ~/Bilder/bg_hori.jpg
elif [ $value -eq 1 ] ; then
	eval "xrandr --output LVDS1 --rotate left"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen stylus' rotate ccw"
	eval "xsetwacom set 'Wacom ISDv4 E6 Finger touch' rotate ccw"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen eraser' rotate ccw"
	feh --bg-scale ~/Bilder/bg_vert.jpg
elif [ $value -eq 2 ] ; then
	eval "xrandr --output LVDS1 --rotate inverted"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen stylus' rotate half"
	eval "xsetwacom set 'Wacom ISDv4 E6 Finger touch' rotate half"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen eraser' rotate half"
	feh --bg-scale ~/Bilder/bg_hori.jpg
elif [ $value -eq 3 ] ; then
	eval "xrandr --output LVDS1 --rotate right"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen stylus' rotate cw"
	eval "xsetwacom set 'Wacom ISDv4 E6 Finger touch' rotate cw"
	eval "xsetwacom set 'Wacom ISDv4 E6 Pen eraser' rotate cw"
	feh --bg-scale ~/Bilder/bg_vert.jpg
fi

~/.dotfiles/Skripte/init.sh
xsetwacom set "Wacom ISDv4 E6 Pen stylus" MapToOutput LVDS1
xsetwacom set "Wacom ISDv4 E6 Pen eraser" MapToOutput LVDS1
xsetwacom set "Wacom ISDv4 E6 Finger touch" MapToOutput LVDS1
