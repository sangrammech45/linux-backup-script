#!/usr/bin/env bash
# backup.sh - back up a folder to a dated .tar.gz and delete old backups.
# Usage: ./backup.sh SOURCE_DIR BACKUP_DIR [KEEP_DAYS]
set -euo pipefail

SOURCE="${1:-}"
DEST="${2:-}"
KEEP_DAYS="${3:-7}"

if [[ -z "$SOURCE" || -z "$DEST" ]]; then
  echo "Usage: $0 SOURCE_DIR BACKUP_DIR [KEEP_DAYS]" >&2
  exit 1
fi
if [[ ! -d "$SOURCE" ]]; then
  echo "Error: source folder '$SOURCE' does not exist." >&2
  exit 1
fi

mkdir -p "$DEST"
LOG="$DEST/backup.log"
STAMP="$(date +%Y-%m-%d_%H-%M-%S)"
ARCHIVE="$DEST/backup_${STAMP}.tar.gz"

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "$LOG"; }

log "Starting backup of $SOURCE"
tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"
log "Created $ARCHIVE ($(du -h "$ARCHIVE" | cut -f1))"

# Remove backups older than KEEP_DAYS days
DELETED="$(find "$DEST" -name 'backup_*.tar.gz' -mtime +"$KEEP_DAYS" -print -delete | wc -l)"
log "Deleted $DELETED backup(s) older than $KEEP_DAYS days"
log "Done"
