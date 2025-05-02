#!/bin/bash
BACKUPDIR="$BACKUP_BASE_DIR/teamspeak"

info "Teamspeak - Restore DB"
docker compose exec -T db mariadb -u root -p"changeme" < "$BACKUPDIR/db.sql"