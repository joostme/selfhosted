BACKUPDIR="$BACKUP_BASE_DIR/teamspeak"
mkdir -p "$BACKUPDIR"

info "Teamspeak - Backup DB"
rm -rf ./data/mariadb/backup
docker compose exec db mariadb-dump --all-databases -u root -p"changeme" > "$BACKUPDIR/db.sql"
