#!/bin/bash
# Build a disposable LVM stack on loopback storage for practice.
set -euo pipefail
IMG=${IMG:-/tmp/lvm-lab.img}; VG=${VG:-vg_lab}; LV=${LV:-lv_data}; MNT=${MNT:-/mnt/lvm-lab}; SIZE=${SIZE:-2G}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
command -v pvcreate >/dev/null || { echo "lvm2 is required." >&2; exit 1; }
truncate -s "$SIZE" "$IMG"
LOOP=$(losetup --find --show "$IMG")
pvcreate -ff -y "$LOOP"; vgcreate "$VG" "$LOOP"; lvcreate -y -n "$LV" -L 1G "$VG"
mkfs.xfs -f "/dev/$VG/$LV"; mkdir -p "$MNT"; mount "/dev/$VG/$LV" "$MNT"
echo "Created /dev/$VG/$LV mounted at $MNT"; lvs; findmnt "$MNT"
