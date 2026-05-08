#!/bin/bash
# Create standard lab users safely and lock password login by default.
set -euo pipefail
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
USERS=${USERS:-"alice bob carol"}; GROUP=${GROUP:-linuxlab}
groupadd -f "$GROUP"
for user in $USERS; do
  if id "$user" >/dev/null 2>&1; then echo "User $user already exists"; else useradd -m -G "$GROUP" "$user"; passwd -l "$user" >/dev/null; echo "Created $user and locked password until instructor sets it"; fi
done
getent group "$GROUP"
