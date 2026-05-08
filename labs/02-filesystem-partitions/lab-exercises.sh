#!/bin/bash
# Create a safe loopback disk for filesystem partition practice.
set -euo pipefail
IMG=${IMG:-/tmp/linux-partition-lab.img}; SIZE=${SIZE:-1G}; MNT=${MNT:-/mnt/partition-lab}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root because losetup, mkfs, and mount require privileges." >&2; exit 1; fi
cleanup() { set +e; mountpoint -q "$MNT" && umount "$MNT"; loopdev=$(losetup -j "$IMG" | awk -F: 'NR==1{print $1}'); [[ -n "${loopdev:-}" ]] && losetup -d "$loopdev"; }
trap cleanup EXIT
truncate -s "$SIZE" "$IMG"
loopdev=$(losetup --find --show "$IMG")
parted -s "$loopdev" mklabel gpt mkpart primary xfs 1MiB 100%
partprobe "$loopdev"; sleep 1
partition="${loopdev}p1"; [[ -b "$partition" ]] || partition="$loopdev"
mkfs.xfs -f "$partition"; mkdir -p "$MNT"; mount "$partition" "$MNT"
echo "hello from filesystem lab" > "$MNT/readme.txt"
findmnt "$MNT"; ls -l "$MNT/readme.txt"
echo "Lab completed. Cleanup will run automatically on exit."
