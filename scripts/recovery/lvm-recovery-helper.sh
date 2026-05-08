#!/bin/bash
# Scan and activate LVM volumes during rescue operations.
set -euo pipefail
if [[ ${EUID} -ne 0 ]]; then echo "Run as root." >&2; exit 1; fi
pvscan; vgscan; vgchange -ay; lvs -a -o +devices; findmnt -rno SOURCE,TARGET,FSTYPE | sort
