BACKUPDIR="$BACKUP_BASE_DIR/vaultwarden"
mkdir -p "$BACKUPDIR"

info "Vault - Backup DB"
sqlite3 ./data/db.sqlite3 ".backup '$BACKUPDIR/vault.sqlite3'"

info "Vault - Backup config"
cp -R ./data/attachments "$BACKUPDIR/attachments"
cp -R ./data/sends "$BACKUPDIR/sends"
cp ./data/config.json "$BACKUPDIR/config.json" 2>/dev/null || :
cp ./data/rsa_key.* "$BACKUPDIR/"