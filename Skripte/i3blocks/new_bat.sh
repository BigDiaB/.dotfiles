#!/bin/bash

raw=$(acpi -b | grep "Battery 0:")


color="#ffffff"
colorb="#000000"

mode="???"
symbol="|???|"
percentage="??%"
time="??:??:??"


percentage=$( echo "$raw" | grep -o [0-9]*% | sed s/%//g)
time=$( echo "$raw" | awk '{ print $5 }' )
discharging=$(echo "$raw" | grep "Discharging") 
if [ -n "$discharging" ]; then
	mode="BAT"
else
	mode="CHR"
fi

if [ $((10#$percentage)) -ge $((10#80)) ]; then
	symbol="|■■■|"; color="#00ff00";
elif [ $((10#$percentage)) -ge $((10#30)) ]; then
	symbol="|■■ |"; color="#aaff00"
elif [ $((10#$percentage)) -ge $((10#20)) ]; then
	symbol="|■  |"; color="#ff0000";
elif [ $((10#$percentage)) -lt $((10#20)) ]; then
	symbol="|   |"; color="#000000"; colorb="#ff0000";
fi

percentage="$percentage%" 

echo -e "<span color='$color' bgcolor='$colorb'> $mode $symbol $percentage $time </span>"
echo -e "<span color='$color' bgcolor='$colorb'> $mode $percentage </span>"

echo "$color"
echo "$color"
echo "$color"

