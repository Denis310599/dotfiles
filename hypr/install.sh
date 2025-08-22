#!/bin/bash

# Install dependencies

#Hyprland
sudo pacman -S hyprland
#Hyprshot
pacman -S hyprshot
#Hyprpaper
pacman -S hyprpaper
#Waybar
pacman -S waybar
#Wofi
pacman -S wofi
#Player ctl
pacman -S playerctl
#pavucontrol
pacman -S pavucontrol
#Backlight control
yay -S backlight_control


# Copy the hyprland config files into their .config directory
