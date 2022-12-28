#!/bin/bash

status="NOBAT"
symbol=""
color="#ffffff"
colorb="#000000"

test=$(acpi | awk '{ print $3 }')
unset test[1]


if [[ $test == *": Full,"* ]]; then
    status="FUL"
    symbol="|■■■|"
    color="#00ff00"
    percentage="100"
else
    discharging=$(acpi | grep Discharging | wc -l) 
    percentage=$(acpi | grep -o [0-9]*% | sed s/%//g)

    time=$(acpi | awk '{ print $5 }')



    if [ $((10#$percentage)) -ge $((10#80)) ]; then
        symbol="|■■■|"; 
    elif [ $((10#$percentage)) -ge $((10#50)) ]; then
        symbol="|■■ |"; 
    elif [ $((10#$percentage)) -ge $((10#20)) ]; then
        symbol="|■  |"; 
    else
        symbol="|   |"; 
    fi

    if [[ $discharging -eq 1 && $((10#$percentage)) -le $((10#10)) && -z "$(acpi | grep 'rate information unavailable')" ]]; then
        notify-send "Akku leer! ($percentage%)" "Mach mich an den Saft du Huan."
    fi

    if [ $discharging -eq 0 ]; then
        if [ $((10#$percentage)) -ge  $((10#99)) ]; then
            status="FUL"
        else
            status="CHR"
        fi
    else
        status="BAT"
    fi
fi

if [[ $status == "NOBAT" ]]; then
    color="#00ff00"
    status="WAL"
    symbol="|CHR|"
    percentage="inf"
else
  a=$(echo "255-$percentage*2.55" | bc)
  red=$(printf '%x' ${a%.*})
  a=$(echo "$percentage*2.55" | bc)
  green=$( printf '%x' ${a%.*})

  percentage="$percentage%" 
  color="#${red}${green}00" 
fi


if [[ $status == "FUL" || $status == "WAL" ]]; then
	echo -e "<span color='$color' bgcolor='$colorb'> $status $symbol $percentage </span>"
else
	echo -e "<span color='$color' bgcolor='$colorb'> $status $symbol $percentage ($time) </span>"
fi

echo -e "<span color='$color' bgcolor='$colorb'> $status $percentage </span>"

echo "$color"
echo "$color"
echo "$color"
