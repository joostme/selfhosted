BACKUPDIR="$BACKUP_BASE_DIR/freshrss"
mkdir -p "$BACKUPDIR"

info "FreshRSS - Backup data"
cp -R ./data/data "$BACKUPDIR/data"
cp -R ./data/extensions "$BACKUPDIR/extensions"