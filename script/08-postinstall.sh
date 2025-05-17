#!/bin/bash
arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/$(cat /tmp/emos_timezone) /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
systemctl enable NetworkManager
EOF
