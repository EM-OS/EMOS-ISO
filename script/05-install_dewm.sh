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
  "i3") pacman -S --noconfirm i3 ;;
  "Awesome") pacman -S --noconfirm awesome ;;
  "bspwm") pacman -S --noconfirm bspwm sxhkd ;;
  "Openbox") pacman -S --noconfirm openbox obconf ;;
  "xmonad") pacman -S --noconfirm xmonad ;;
esac
EOF
