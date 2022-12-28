#!/bin/bash


valuefile="/tmp/numpad.dat"

if [ ! -f "$valuefile" ]; then
	value=0
else
	value=$(cat "$valuefile")
fi
value=$((value + 1))
if [ $value -ge 2 ]; then
	value=0
fi
echo "${value}" > "$valuefile"

if [[ $value -eq 1 ]]; then
	xset led named 'Caps Lock'
	xmodmap -e 'keycode 19 = slash'

	xmodmap -e 'keycode 30 = 4'
	xmodmap -e 'keycode 31 = 5'
	xmodmap -e 'keycode 32 = 6'
	xmodmap -e 'keycode 33 = asterisk'

	xmodmap -e 'keycode 44 = 1'
	xmodmap -e 'keycode 45 = 2'
	xmodmap -e 'keycode 46 = 3'
	xmodmap -e 'keycode 47 = minus'

	xmodmap -e 'keycode 58 = 0'
	xmodmap -e 'keycode 61 = plus'
	xmodmap -e 'keycode 32 = 6'
else
	xset -led named 'Caps Lock'
	setxkbmap de -option ctrl:nocaps
fi

