#!/bin/bash

brightness="$(xbacklight -get | cut -f1 -d'.')"
symbol=""
color="#ffff00"
colorb="#000000"

if [ $((10#$brightness)) -ge $((10#80)) ]; then
    symbol="|■■■|"
elif [ $((10#$brightness)) -ge $((10#50)) ]; then
    symbol="|■■ |"
elif [ $((10#$brightness)) -ge $((10#10)) ]; then
    symbol="|■  |"
else
    symbol="|   |"
fi

#red=$(printf '%x' $(echo "$brightness*2.55" | bc))
#green=$(printf '%x' $(echo "$brightness*2.55" | bc))

#color="#${red}${green}00"

echo -e "<span color='$color' bgcolor='$colorb'> BKL $symbol $brightness% </span>"
echo -e "<span color='$color' bgcolor='$colorb'> BKL $brightness% </span>"
echo $color
echo $color
echo $color
