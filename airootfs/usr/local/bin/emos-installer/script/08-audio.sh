#!/bin/bash
set -e

audio_choice=$(gum choose --header="Select audio system to install:" \
  "PipeWire (recommended)" "PulseAudio" "None")

echo "[INFO] Selected: $audio_choice"

if [[ "$audio_choice" == "PipeWire (recommended)" ]]; then
  arch-chroot /mnt pacman -S --noconfirm --needed \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack \
    wireplumber alsa-utils pavucontrol alsa-ucm-conf pipewire-audio

  arch-chroot /mnt systemctl enable pipewire.socket
  arch-chroot /mnt systemctl enable pipewire-pulse.socket

elif [[ "$audio_choice" == "PulseAudio" ]]; then
  arch-chroot /mnt pacman -S --noconfirm --needed \
    pulseaudio pulseaudio-alsa alsa-utils pavucontrol

elif [[ "$audio_choice" == "None" ]]; then
  echo "[INFO] No audio packages will be installed."
else
  echo "[ERROR] Invalid selection."
  exit 1
fi

echo "[INFO] Audio setup complete."

