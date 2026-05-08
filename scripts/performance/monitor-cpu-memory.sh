#!/bin/bash
# Lightweight CPU and memory sampler for lab troubleshooting.
set -euo pipefail
INTERVAL=${INTERVAL:-2}; COUNT=${COUNT:-10}
for ((i=1; i<=COUNT; i++)); do
  echo "== sample $i $(date -Is) =="; uptime; free -h; ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -10; sleep "$INTERVAL"
done
