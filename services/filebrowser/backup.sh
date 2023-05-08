BACKUPDIR="$BACKUP_BASE_DIR/filebrowser"
mkdir -p "$BACKUPDIR"

info "Filebrowser - Backup data"
cp -R ./data/files "$BACKUPDIR/files"
cp -R ./data/database "$BACKUPDIR/database"