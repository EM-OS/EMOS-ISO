# #!/bin/bash
# set -euo pipefail

# log() {
#   echo -e "\e[1;32m[INFO]\e[0m $*"
# }

# error() {
#   echo -e "\e[1;31m[ERROR]\e[0m $*" >&2
#   exit 1
# }

# log "Updating mirrorlist with Reflector..."

# arch-chroot /mnt /bin/bash <<EOF
# # Ensure reflector is installed (failsafe)
# pacman -S --noconfirm --needed reflector

# # Update the mirrorlist using the fastest recent HTTPS mirrors
# reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# # Optionally enable weekly refresh of mirrors
# systemctl enable reflector.timer

# EOF

# log "Mirrorlist updated and reflector.timer enabled."
#!/bin/bash
set -euo pipefail

log() {
  echo -e "\e[1;32m[INFO]\e[0m $*"
}

error() {
  echo -e "\e[1;31m[ERROR]\e[0m $*" >&2
  exit 1
}

# Check if /mnt is mounted
if ! mountpoint -q /mnt; then
  error "/mnt is not mounted. Cannot proceed with mirrorlist update."
fi

log "Updating mirrorlist with Reflector..."

arch-chroot /mnt /bin/bash <<EOF
set -euo pipefail

# Install reflector if missing
pacman -S --noconfirm --needed reflector || exit 1

# Generate a fast, up-to-date, country-specific mirrorlist
if ! reflector \
  --latest 10 \
  --country "US,DE,FR" \  # Adjust based on your location
  --protocol https \
  --age 12 \              # Only mirrors synced in the last 12 hours
  --sort rate \
  --save /etc/pacman.d/mirrorlist; then
  echo "Warning: Failed to update mirrors. Using existing mirrorlist."
fi

# Enable automatic weekly updates
systemctl enable reflector.timer

EOF

log "Mirrorlist updated and reflector.timer enabled."