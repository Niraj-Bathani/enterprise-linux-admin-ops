#!/bin/bash
# Extend an existing logical volume and grow the filesystem.
set -euo pipefail
LV_PATH=${1:-}; GROW_BY=${2:-+512M}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
if [[ -z "$LV_PATH" || ! -e "$LV_PATH" ]]; then echo "Usage: $0 /dev/vg_name/lv_name [+SIZE]" >&2; exit 2; fi
before=$(lvs --noheadings -o lv_size "$LV_PATH" | xargs); echo "Before: $LV_PATH size $before"
lvextend -r -L "$GROW_BY" "$LV_PATH"
after=$(lvs --noheadings -o lv_size "$LV_PATH" | xargs); echo "After: $LV_PATH size $after"
findmnt "$LV_PATH" || true
