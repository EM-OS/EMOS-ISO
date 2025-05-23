#!/bin/bash

airootfs=("../airootfs/etc")

# Grub
mkdir -p "$airootfs/default"
cp -r "/etc/default/grub" "$airootfs/default"

# os-release
cp "/usr/lib/os-release" "$airootfs"
sed -i 's/NAME="RebornOS Linux"/NAME="EMOS Linux"/' "$airootfs/os-release"

# Wheel Group
mkdir -p "$airootfs/sudoers.d"
g_wheel="$airootfs/sudoers.d/g_wheel"
echo "%wheel ALL=(ALL:ALL) ALL" > "$g_wheel"

# Symbolic Links
mkdir -p "$airootfs/systemd/system/multi-user.target.wants"
ln -sf "/usr/lib/systemd/system/NetworkManager.service" "$airootfs/systemd/system/multi-user.target.wants"

mkdir -p "$airootfs/systemd/system/network-online.target.wants"
ln -sf "/usr/lib/systemd/system/NetworkManager-wait-online.service" "$airootfs/systemd/system/network-online.target.wants"

ln -sf "/usr/lib/systemd/system/NetworkManager-dispatcher.service" "$airootfs/systemd/system/dbus.org.freedesktop.dispatcher.service"

ln -sf "/usr/lib/systemd/system/bluetooth.service" "$airootfs/systemd/system/network-online.target.wants"

ln -sf "/usr/lib/systemd/system/graphical.service" "$airootfs/systemd/system/default.target"

ln -sf "/usr/lib/systemd/system/sddm.service" "$airootfs/systemd/system/display-manager.service"

# SDDM Config
mkdir -p "$airootfs/sddm.conf.d"
head -n '35' "/usr/lib/sddm/sddm.conf.d/default.conf" > "$airootfs/sddm.conf"
sed -n '38,137p' "/usr/lib/sddm/sddm.conf.d/default.conf" > "$airootfs/sddm.conf.d/kde_settings.conf"

# Customize SDDM Config
sed -i 's|^Session=.*|Session=hyprland.desktop|' "$airootfs/sddm.conf"
sed -i 's|^DisplayServer=.*|DisplayServer=wayland|' "$airootfs/sddm.conf"
sed -i 's|^Numlock=off|Numlock=on|' "$airootfs/sddm.conf"



mkdir -p "$airootfs/usr/share/wayland-sessions"
cat > "$airootfs/usr/share/wayland-sessions/hyprland.desktop" <<EOF
[Desktop Entry]
Name=Hyprland
Comment=Hyprland Wayland compositor
Exec=Hyprland
Type=Application
EOF

mkdir -p "$airootfs/usr/share/wayland-sessions"
cat > "$airootfs/usr/share/wayland-sessions/plasmawayland.desktop" <<EOF
[Desktop Entry]
Name=Plasma (Wayland)
Comment=Plasma Desktop using Wayland
Exec=startplasma-wayland
Type=Application
EOF

mkdir -p "$airootfs/usr/share/xsessions"
cat > "$airootfs/usr/share/xsessions/plasma.desktop" <<EOF
[Desktop Entry]
Name=Plasma (X11)
Comment=Plasma Desktop using X11
Exec=startplasma-x11
Type=Application
EOF

# Add User
user="em"
sed -i "s|^User=.*|User=$user|" "$airootfs/sddm.conf"

# Hostname
echo "emos" > "$airootfs/hostname"

# Add user entry to passwd
if grep -q "^$user:" "$airootfs/passwd" 2>/dev/null; then
    echo -e "\nUser Found....."
else
    echo "$user:x:1000:1000::/home/$user:/usr/bin/bash" >> "$airootfs/passwd"
    echo -e "\nUser not Found....."
fi

# Password
hash_pd=$(openssl passwd -6 Beta2026!)

if grep -q "^$user:" "$airootfs/shadow"; then
    echo -e "\nPassword exists, Not Modifying."
else
    echo "$user:$hash_pd:14871::::::" >> "$airootfs/shadow"
    echo -e "\nModifying the Password"
fi

# Group
touch "$airootfs/group"
echo -e "root:x:0:root\nadm:x:4:$user\nwheel:x:10:$user\nuucp:x:14:$user\n$user:x:1000:$user" > "$airootfs/group"

# gshadow
touch "$airootfs/gshadow"
echo -e "root:!*::root\n$user:!*::" > "$airootfs/gshadow"

# Set Kitty as the default terminal in KDE
# mkdir -p "$airootfs/home/$user/.config"
# echo -e "[General]\nTerminalApplication=kitty" > "$airootfs/home/$user/.config/kdeglobals"



# Grub cfg
grubcfg="../grub/grub.cfg"
sed -i 's/default=archlinux/default=emos/' "$grubcfg"
sed -i 's/timeout=15/timeout=10/' "$grubcfg"
sed -i 's/menuentry "Arch/menuentry "EMOS/' "$grubcfg"

if ! grep -q "cow_spacesize=10G copytoram=n" "$grubcfg" 2>/dev/null; then
    sed -i 's/archisosearchuuid=%ARCHISO_UUID%/archisosearchuuid=%ARCHISO_UUID% cow_spacesize=10G copytoram=n/' "$grubcfg"
fi

if ! grep -q "#play" "$grubcfg" 2>/dev/null; then
    sed -i 's/play/#play/' "$grubcfg"
fi

# EFI bootloader entries
efiloader="../efiboot/loader"
sed -i 's/Arch/EMOS/' "$efiloader/entries/01-archiso-x86_64-linux.conf"
sed -i 's/Arch/EMOS/' "$efiloader/entries/02-archiso-x86_64-speech-linux.conf"

# Loader config
sed -i 's/timeout 15/timeout 10/' "$efiloader/loader.conf"
sed -i 's/beep on/beep off/' "$efiloader/loader.conf"
