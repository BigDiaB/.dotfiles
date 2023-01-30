#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap de -option ctrl:nocaps &
feh --bg-scale ~/Bilder/bg_hori.jpg &
#dunst -conf ~/.dotfiles/dunst.conf &
#blueman-applet &
#cbatticon &
#nm-applet &
#pasystray &
export $(dbus-launch)

exec "~/.dotfiles/Skripte/natural_scrolling.sh" &
exec "~/.dotfiles/Skripte/tap_click.sh" &
exec "~/.dotfiles/Skripte/init.sh" &

picom --config ~/.dotfiles/picom.conf &
fcitx -d &
dunst -conf ~/.dotfiles/dunst.conf &

#sxhkd -c ~/.dotfiles/sxhkd.conf &
#bspwm -c ~/.dotfiles/bspwm.conf
i3 -c ~/.dotfiles/i3wm.conf
#exec dbus-launch-session  "i3 -c ~/.dotfiles/i3wm.conf"
