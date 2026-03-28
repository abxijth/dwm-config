#!/bin/sh

xrdb merge ~/.config/st/xresources
xbacklight -set 10 &
feh --bg-fill ~/Pictures/wall/wall.png &
xset r rate 200 50 &
picom &
sxhkd &


dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
