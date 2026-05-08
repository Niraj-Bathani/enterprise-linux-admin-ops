#!/bin/bash
# Show open file usage for a process or the top system users.
set -euo pipefail
if [[ $# -gt 0 ]]; then
  PID=$1; [[ -d /proc/$PID ]] || { echo "PID $PID not found" >&2; exit 2; }
  ls "/proc/$PID/fd" | wc -l; command -v lsof >/dev/null 2>&1 && lsof -p "$PID" | head -50
else
  for p in /proc/[0-9]*; do pid=${p##*/}; count=$(ls "$p/fd" 2>/dev/null | wc -l || true); comm=$(cat "$p/comm" 2>/dev/null || true); printf '%6s %6s %s\n' "$count" "$pid" "$comm"; done | sort -nr | head -20
fi
