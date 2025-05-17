#!/bin/bash
arch-chroot /mnt /bin/bash <<EOF
echo "Set root password:"
passwd
username=$(gum input --placeholder "emos" --prompt "Enter new username:")
useradd -m -G wheel -s /bin/bash "$username"
passwd "$username"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
EOF
