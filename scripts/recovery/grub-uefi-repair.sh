#!/bin/bash
# Helper checklist for repairing GRUB on UEFI systems from rescue media.
set -euo pipefail
ROOT=${ROOT:-/mnt/sysimage}; EFI=${EFI:-/boot/efi}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
for d in dev proc sys run; do mountpoint -q "$ROOT/$d" || mount --bind "/$d" "$ROOT/$d"; done
chroot "$ROOT" grub2-mkconfig -o /boot/grub2/grub.cfg
chroot "$ROOT" dnf reinstall -y grub2-efi-x64 shim-x64 || true
chroot "$ROOT" efibootmgr -v || true
echo "Review output, unmount bind mounts, then reboot when ready. EFI mount expected at $EFI."
