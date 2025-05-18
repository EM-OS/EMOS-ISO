#!/bin/bash
de=$(gum choose "KDE Plasma" "GNOME" "XFCE" "Cinnamon" "MATE" "LXQt" "Budgie" "None")
wm=$(gum choose "i3" "Awesome" "bspwm" "Openbox" "xmonad" "Hyprland" "None")
echo "$de" > /tmp/emos_de
echo "$wm" > /tmp/emos_wm
