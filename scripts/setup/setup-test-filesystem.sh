#!/bin/bash
# Prepare a test directory tree for permissions, ACL, and quota labs.
set -euo pipefail
BASE=${BASE:-/srv/linuxlab}
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
mkdir -p "$BASE"/{shared,private,logs,tmp}
chmod 2775 "$BASE/shared"; chmod 700 "$BASE/private"; chmod 1777 "$BASE/tmp"
for i in {1..5}; do echo "sample log $i" > "$BASE/logs/app-$i.log"; done
find "$BASE" -maxdepth 2 -printf '%M %u %g %p\n'
