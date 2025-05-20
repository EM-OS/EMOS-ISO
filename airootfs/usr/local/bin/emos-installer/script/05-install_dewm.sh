#!/bin/bash
de=$(cat /tmp/emos_de)
wm=$(cat /tmp/emos_wm)
arch-chroot /mnt /bin/bash <<EOF
case "$de" in
  "KDE Plasma") pacman -S --noconfirm plasma kde-applications sddm && systemctl enable sddm ;;
  "GNOME") pacman -S --noconfirm gnome gdm && systemctl enable gdm ;;
  "XFCE") pacman -S --noconfirm xfce4 xfce4-goodies lightdm lightdm-gtk-greeter && systemctl enable lightdm ;;
  "Cinnamon") pacman -S --noconfirm cinnamon lightdm lightdm-gtk-greeter && systemctl enable lightdm ;;
  "MATE") pacman -S --noconfirm mate mate-extra lightdm lightdm-gtk-greeter && systemctl enable lightdm ;;
  "LXQt") pacman -S --noconfirm lxqt lightdm lightdm-gtk-greeter && systemctl enable lightdm ;;
  "Budgie") pacman -S --noconfirm budgie-desktop gnome-terminal lightdm lightdm-gtk-greeter && systemctl enable lightdm ;;
esac

case "$wm" in
  "i3")pacman -S --noconfirm i3 xterm dmenu i3status i3lock picom notify-osd greetd greetd-regreet && systemctl enable greetd;;
  "Awesome")pacman -S --noconfirm awesome xterm rofi picom notify-osd greetd greetd-regreet && systemctl enable greetd;;
  "bspwm")pacman -S --noconfirm bspwm sxhkd xterm rofi picom polybar dunst greetd greetd-regreet && systemctl enable greetd;;
  "Openbox")pacman -S --noconfirm openbox obconf xterm tint2 rofi picom notify-osd greetd greetd-regreet && systemctl enable greetd;;
  "xmonad") pacman -S --noconfirm xmonad xmonad-contrib xterm dmenu trayer picom dunst greetd greetd-regreet && systemctl enable greetd;;
  "Hyprland") pacman -S --noconfirm hyprland waybar hyprpaper cmake cpio kitty greetd greetd-regreet dunst qt5-wayland qt6-wayland network-manager-applet hyprpolkitagent xdg-desktop-portal-hyprland xdg-desktop-portal && systemctl enable greetd;;
esac
EOF
