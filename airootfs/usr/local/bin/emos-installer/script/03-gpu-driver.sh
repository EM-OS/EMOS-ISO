#!/bin/bash

driver=$(gum choose "NVIDIA (proprietary)" "NVIDIA (open)" "AMD" "Intel" "Skip")

echo "$driver" > /tmp/emos_gpu

arch-chroot /mnt /bin/bash <<EOF
case "$driver" in
  "NVIDIA (proprietary)")
    pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
    ;;
  "NVIDIA (open)")
    pacman -S --noconfirm nvidia-open-dkms nvidia-utils nvidia-settings
    ;;
  "AMD")
    pacman -S --noconfirm mesa vulkan-radeon libva-mesa-driver xf86-video-amdgpu
    ;;
  "Intel")
    pacman -S --noconfirm mesa vulkan-intel libva-intel-driver libva-utils xf86-video-intel
    ;;
  "Skip")
    echo "Skipping GPU driver install"
    ;;
esac
EOF
