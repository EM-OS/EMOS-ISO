# #!/bin/bash
# set -euo pipefail

# # Let user choose multiple packages
# extras=$(gum choose --no-limit "firefox" "chromium" "vlc" "gimp")

# # Save selections for record
# echo "$extras" > /tmp/emos_extras

# if [[ -z "$extras" ]]; then
#   echo "No extra packages selected. Skipping installation."
#   exit 0
# fi

# echo "You selected: $extras"

# # Filter out already installed packages
# to_install=()
# for pkg in $extras; do
#   if ! arch-chroot /mnt pacman -Qq "$pkg" &>/dev/null; then
#     to_install+=("$pkg")
#   else
#     echo "Package '$pkg' is already installed, skipping."
#   fi
# done

# if [[ ${#to_install[@]} -eq 0 ]]; then
#   echo "All selected packages are already installed. Nothing to do."
#   exit 0
# fi

# echo "Installing packages: ${to_install[*]}"
# arch-chroot /mnt pacman -S --noconfirm "${to_install[@]}"

#!/bin/bash
set -euo pipefail

# Fetch remote package list (e.g., from GitHub Raw URL)
REMOTE_PKG_LIST="https://raw.githubusercontent.com/EM-OS/EMOS-PACKAGES/refs/heads/main/packages.txt"

# Download the list and extract package names
AVAILABLE_PKGS=$(curl -s "$REMOTE_PKG_LIST" | grep -v '^#' | tr '\n' ' ')

if [[ -z "$AVAILABLE_PKGS" ]]; then
  echo "Error: Could not fetch remote package list."
  exit 1
fi

# Let user choose multiple packages
extras=$(gum choose --no-limit $AVAILABLE_PKGS)

# Save selections for record
echo "$extras" > /tmp/emos_extras

if [[ -z "$extras" ]]; then
  echo "No extra packages selected. Skipping installation."
  exit 0
fi

echo "You selected: $extras"

# Filter out already installed packages
to_install=()
for pkg in $extras; do
  if ! arch-chroot /mnt pacman -Qq "$pkg" &>/dev/null; then
    to_install+=("$pkg")
  else
    echo "Package '$pkg' is already installed, skipping."
  fi
done

if [[ ${#to_install[@]} -eq 0 ]]; then
  echo "All selected packages are already installed. Nothing to do."
  exit 0
fi

echo "Installing packages: ${to_install[*]}"
arch-chroot /mnt pacman -S --noconfirm "${to_install[@]}"