#!/bin/bash
# Simple rsync backup with retention for lab systems.
set -euo pipefail
SRC=${SRC:-/etc}; DEST=${DEST:-/var/backups/lab-system}; RETENTION=${RETENTION:-7}; STAMP=$(date +%F-%H%M%S); TARGET="$DEST/$STAMP"
if [[ ! -d "$SRC" ]]; then echo "Source $SRC does not exist." >&2; exit 2; fi
mkdir -p "$TARGET"
if command -v rsync >/dev/null 2>&1; then rsync -aHAX --numeric-ids "$SRC/" "$TARGET/"; else tar -C "$SRC" -cpf "$TARGET/backup.tar" .; fi
ln -sfn "$TARGET" "$DEST/latest"
find "$DEST" -mindepth 1 -maxdepth 1 -type d -mtime +"$RETENTION" -print -exec rm -rf {} +
echo "Backup completed at $TARGET"
