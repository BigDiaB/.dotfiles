#!/bin/bash

brightness="$(brightnessctl -m | grep -o [0-9]*% | sed s/%//g)"
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

red=$(printf '%x' $(echo "$brightness*2.55+50" | bc | awk '{print int($1+0.5)}'))
green=$(printf '%x' $(echo "$brightness*2.55+50" | bc | awk '{print int($1+0.5)}'))

if [ $((16#$red)) -ge $((10#255)) ]; then
    red="ff"
fi

if [ $((16#$green)) -ge $((10#255)) ]; then
    green="ff"
fi


color="#${red}${green}00"


echo -e "<span color='$color' bgcolor='$colorb' background_alpha='1'> BKL $symbol $brightness% </span>"
echo -e "<span color='$color' bgcolor='$colorb' background_alpha='1'> BKL $brightness% </span>"
echo $color
echo $color
echo $color
