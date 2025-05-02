BACKUPDIR="$BACKUP_BASE_DIR/tandoor"
mkdir -p "$BACKUPDIR"

info "Tandoor - Backup DB"
docker compose exec db_recipes pg_dump -U djangouser djangodb > "$BACKUPDIR/db.sql"