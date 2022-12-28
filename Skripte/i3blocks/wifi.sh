#!/usr/bin/env bash

w_interface="wlp3s0"
e_interface="enp0s25"

if [[ "$(cat /sys/class/net/$w_interface/operstate)" = 'up' ]]; then
    if [[ "$(cat /sys/class/net/$e_interface/operstate)" = 'up' ]]; then
        type="W+E"
    else
        type="WRL"
    fi
elif [[ "$(cat /sys/class/net/$e_interface/operstate)" = 'up' ]]; then
    type="ETH"
else
    type="NON"
fi

color="#ffffff"
colorb="#000000"
symbol="|???|"

if [[ $type = 'WRL' || $type == 'W+E' ]]; then
    QUALITY=$(iw dev ${w_interface} link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')

    if [[ $QUALITY -ge 60 ]]; then
        symbol="|■■■|"
        color="#00FF00"
    elif [[ $QUALITY -ge 40 ]]; then
        symbol="|■■ |"
        color="#FFF600"
    elif [[ $QUALITY -ge 20 ]]; then
        symbol="|■  |"
        color="#FFAE00"
    else
        symbol="|  |"
        color="#FF0000"
    fi

    QUALITY="$QUALITY%"

elif [[ $type != 'NON' ]]; then
    color="#00ffaa"
    QUALITY="LNK"
    symbol="|EST|"
else
    color="#ff0000"
    QUALITY=""
    symbol="|---|"
fi

echo -e "<span color='$color' bgcolor='$colorb'> $type $symbol $QUALITY </span>"
echo -e "<span color='$color' bgcolor='$colorb'> $type $QUALITY </span>"
echo "$color"
echo "$color"
echo "$color"
fi
