#!/usr/bin/env bash

# Find out your monitor name with xrandr or arandr (save and you get this line)
# xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
# xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
# xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
# xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

# autostart applications at boot time
nm-applet &
xfce4-power-manager &
numlockx on &
picom --config "$HOME/.config/qtile/picom/picom.conf" &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
