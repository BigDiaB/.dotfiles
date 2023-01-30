SCR_DIR="~/.dotfiles/Skripte/i3blocks"

CLK="$SCR_DIR/time.sh"
BKL="$SCR_DIR/backlight.sh"
VOL="$SCR_DIR/volume.sh"
BAT="$SCR_DIR/new_bat.sh"
NET="$SCR_DIR/wifi.sh"
CPU="$SCR_DIR/cpu.sh"

notify-send -u low "System-Status:" \
"$(exec $CLK | head -n 1)\n\
$(exec $BKL | head -n 1)\n\
$(exec $VOL | head -n 1)\n\
$(exec $BAT | head -n 1)\n\
$(exec $NET | head -n 1)\n\
$(exec $CPU | head -n 1)\n"
