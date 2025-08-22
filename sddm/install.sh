#!/bin/bash
pacman -Sy sddm

# Start service
systemctl enable sddm.service

# Set up the theme
cp -r ./sddm-astronaut-theme /usr/share/sddm/themes/

# Copy configuration
cp ./default.conf /etc/sddm.conf.d/

