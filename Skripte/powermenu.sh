#!/bin/bash



option=$(zenity --width=360 --height=320 --list --title "Powermenu" --text "Ich will" --column "Optionen" "Ausloggen" "Winterschlaf" "Neustart" "Runterfahren")



if [ "$option" = "Ausloggen" ]; then

    i3-msg exit

elif [ "$option" = "Winterschlaf" ]; then

    sudo systemctl hibernate

elif [ "$option" = "Neustart" ]; then

    sudo reboot

elif [ "$option" = "Runterfahren" ]; then

    sudo shutdown now

else

    exit 0



fi