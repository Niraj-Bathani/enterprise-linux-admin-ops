#!/bin/bash
# Perform a timestamped live backup of selected directories.
set -euo pipefail
DEST=${DEST:-/var/backups/live}; SOURCES=${SOURCES:-"/etc /var/www"}; STAMP=$(date +%F-%H%M%S); TARGET="$DEST/$STAMP"
mkdir -p "$TARGET"
for src in $SOURCES; do
  [[ -e "$src" ]] || { echo "Skipping missing $src"; continue; }
  name=$(echo "$src" | sed 's#^/##; s#/#_#g')
  tar --xattrs --acls -czf "$TARGET/$name.tgz" -C "$(dirname "$src")" "$(basename "$src")"
done
sha256sum "$TARGET"/*.tgz > "$TARGET/SHA256SUMS"
echo "Backup stored in $TARGET"
