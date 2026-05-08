#!/bin/bash
# Report filesystem and largest directory usage for quick triage.
set -euo pipefail
PATH_TO_SCAN=${1:-/var}
echo "== Filesystems =="; df -hT
echo "== Largest entries under $PATH_TO_SCAN =="; du -xhd1 "$PATH_TO_SCAN" 2>/dev/null | sort -h | tail -20
echo "== Deleted files still held open =="; command -v lsof >/dev/null 2>&1 && lsof +L1 | head -50 || echo "Install lsof for deleted-file checks."
