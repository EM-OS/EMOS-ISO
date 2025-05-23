#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="emos"
iso_label="EMOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="EMOS Linux <https://archlinux.org>"
iso_application="EMOS Linux Live/Rescue DVD"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
           'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/etc/sudoers.d/g_wheel"]="0:0:440"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/emos-installer/emos-installer.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/00-welcome.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/01-partition.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/02-install_base.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/03-gpu-driver.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/04-select_dewm.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/05-install_dewm.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/06-user.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/07-mirrors.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/08-audio.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/09-packages.sh"]="0:0:755"
  ["/usr/local/bin/emos-installer/script/10-postinstall.sh"]="0:0:755"
)
