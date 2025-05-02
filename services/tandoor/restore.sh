#!/bin/bash
BACKUPDIR="$BACKUP_BASE_DIR/tandoor"

info "Tandoor - Restore DB"
docker compose exec -T db_recipes psql -X -U djangouser -d djangodb <  "$BACKUPDIR/db.sql"