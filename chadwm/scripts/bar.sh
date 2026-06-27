#!/bin/dash

# ^c$var^ = foreground color
# ^b$var^ = background color

. "$HOME/.config/chadwm/scripts/bar_themes/tundra"

cpu() {
    cpu_load=$(cut -d' ' -f1 /proc/loadavg)

    printf "^c$black^ ^b$green^ CPU"
    printf "^c$white^ ^b$grey^ %s ^b$black^" "$cpu_load"
}

mem() {
    memory_used=$(free -m | awk '/^Mem:/ {printf "%.1fG", $3/1024}')

    printf "^c$black^ ^b$red^ MEM"
    printf "^c$white^ ^b$grey^ %s ^b$black^" "$memory_used"
}

clock() {
    printf "^c$black^ ^b$darkblue^ 󱑆 "
    printf "^c$black^ ^b$blue^ %s ^b$black^" "$(date '+%H:%M')"
}

while :; do
    xsetroot -name "  $(cpu)$(mem)$(clock)"
    sleep 1
done
