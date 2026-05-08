#!/bin/bash
# Collect a short sysstat report. Requires the sysstat package.
set -euo pipefail
OUT=${OUT:-/tmp/sar-report-$(date +%F-%H%M%S).txt}
if ! command -v sar >/dev/null 2>&1; then echo "Install sysstat for sar." >&2; exit 1; fi
{ echo "# CPU"; sar -u 1 5; echo "# Memory"; sar -r 1 5; echo "# Disk"; sar -d 1 5; echo "# Network"; sar -n DEV 1 5; } | tee "$OUT"
echo "Report written to $OUT"
