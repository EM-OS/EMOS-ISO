#!/bin/bash
pacstrap /mnt base linux linux-firmware sudo networkmanager grub efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
cp /tmp/emos_hostname /mnt/etc/hostname
