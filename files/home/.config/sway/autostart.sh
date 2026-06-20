#!/bin/bash
# Autostart applications for LumiDistro

# Wallpaper
feh --bg-scale ~/.config/wallpaper.jpg &

# Notifications
dunst &

# System tray
blueman-applet &
nm-applet &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Compositor (optional, for transparency)
picom --config ~/.config/picom.conf &
