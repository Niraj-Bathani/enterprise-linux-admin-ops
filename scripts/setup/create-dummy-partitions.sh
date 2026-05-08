#!/bin/bash
# Create a loopback disk and optional GPT partitions for storage labs.
set -euo pipefail
IMG=${IMG:-/tmp/dummy-disk.img}; SIZE=${SIZE:-4G}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
truncate -s "$SIZE" "$IMG"
LOOP=$(losetup --find --show "$IMG")
parted -s "$LOOP" mklabel gpt mkpart primary 1MiB 1025MiB mkpart primary 1025MiB 2049MiB mkpart primary 2049MiB 100%
partprobe "$LOOP"; echo "Created $LOOP from $IMG"; lsblk "$LOOP"
