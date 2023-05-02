BACKUPDIR="$BACKUP_BASE_DIR/ntfy"
mkdir -p "$BACKUPDIR"

info "ntfy - Backup data"
cp -R ./data/cache "$BACKUPDIR/cache"
cp -R ./data/etc "$BACKUPDIR/etc"
cp -R ./data/lib "$BACKUPDIR/lib"