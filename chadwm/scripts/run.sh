#!/bin/sh
xrandr --output HDMI-2 --mode 1920x1080 --rate 74.97 &
xrdb merge ~/.config/st/xresources
xbacklight -set 10 &
feh --bg-fill ~/Pictures/Wallpapers/wallpaper.jpg &
xset r rate 200 50 &
picom --config ~/.config/picom/picom.conf &
sxhkd &


dash ~/.config/chadwm/scripts/bar.sh &
while type chadwm >/dev/null; do chadwm && continue || break; done
