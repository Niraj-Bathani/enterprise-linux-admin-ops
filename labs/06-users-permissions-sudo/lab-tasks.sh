#!/bin/bash
# Create disposable users, groups, and permission examples for the lab.
set -euo pipefail
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
GROUP=${GROUP:-opslab}; BASE=${BASE:-/srv/opslab}; USERS=(opsalice opsbob)
groupadd -f "$GROUP"; mkdir -p "$BASE/shared"; chgrp "$GROUP" "$BASE/shared"; chmod 2770 "$BASE/shared"
for user in "${USERS[@]}"; do
  id "$user" >/dev/null 2>&1 || useradd -m -G "$GROUP" "$user"
  passwd -l "$user" >/dev/null || true
  echo "$user created and added to $GROUP"
done
setfacl -m g:"$GROUP":rwx "$BASE/shared" 2>/dev/null || echo "setfacl unavailable; install acl package."
namei -l "$BASE/shared"; getfacl "$BASE/shared" 2>/dev/null || true
