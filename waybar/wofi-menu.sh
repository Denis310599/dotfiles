#!/bin/bash

entries="logout\nsuspend\nreboot\nshutdown"

selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu| awk '{print $1}')
echo "Seleccionado: ${selected}"

case $selected in
  logout)
    hyprctl dispatch exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac