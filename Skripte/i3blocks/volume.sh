#!/bin/bash

muted=$( pactl get-sink-mute @DEFAULT_SINK@ )
volume=$( pactl get-sink-volume @DEFAULT_SINK@ | grep Volume  | head -n1 | awk '{print $5}' | sed 's/%//' )
micmute=$( pacmd list-sources | grep muted: | tail -n 1 )
symbol=""
color="#aaafff"
colorb="#000000"
status="VOL"

if [[ $micmute == *"yes"* ]]; then
    colorb="#400000"
fi

if [ $((volume)) -ge $((10#100)) ]; then
  pactl set-sink-volume @DEFAULT_SINK@ 100%
  volume="100"
fi

if [ $((10#$volume)) -ge $((10#80)) ]; then
    symbol="|■■■|"
elif [ $((10#$volume)) -ge $((10#50)) ]; then
    symbol="|■■ |"
elif [ $((10#$volume)) -ge $((10#30)) ]; then
    symbol="|■  |"
else
    symbol="|   |"
fi

if [[ $muted =~ "ja" ]]; then
    color="#ffaaaa"
    status="MUT"
fi

echo -e "<span color='$color' bgcolor='$colorb'> $status $symbol $volume% </span>"
echo -e "<span color='$color' bgcolor='$colorb'> $status $volume% </span>"
echo "$color"
echo "$color"
echo "$color"