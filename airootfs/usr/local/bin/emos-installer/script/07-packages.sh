#!/bin/bash
extras=$(gum choose --no-limit "firefox" "chromium" "git" "neovim" "vlc" "gimp" "htop")
echo "$extras" > /tmp/emos_extras
arch-chroot /mnt pacman -S --noconfirm $extras
