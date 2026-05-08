#!/bin/bash
# Report Linux software RAID status and exit nonzero if an array is degraded.
set -euo pipefail
status=0
echo "== /proc/mdstat =="; cat /proc/mdstat
if command -v mdadm >/dev/null 2>&1; then
  while read -r mddev; do
    [[ -b "$mddev" ]] || continue
    echo "== mdadm detail for $mddev =="; mdadm --detail "$mddev" || status=1
    if mdadm --detail "$mddev" | grep -Eiq 'State :.*degraded|Failed Devices : [1-9]'; then status=2; fi
  done < <(awk '/^md[0-9]+/ {print "/dev/" $1}' /proc/mdstat)
else
  echo "mdadm not installed; install it for detailed checks." >&2; status=1
fi
exit "$status"
