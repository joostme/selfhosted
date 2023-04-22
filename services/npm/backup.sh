#!/bin/bash
BACKUPDIR="$BACKUP_BASE_DIR/npm"
mkdir -p "$BACKUPDIR"

info "NGINX Proxy Manager - Backup DB"
sqlite3 ./data/database.sqlite ".backup '$BACKUPDIR/database.sqlite3'"

info "NGINX Proxy Manager - Backup config"
cp ./data/keys.json "$BACKUPDIR/keys.json"
cp -R ./data/nginx "$BACKUPDIR/nginx"
cp -R ./data/access "$BACKUPDIR/access"
cp -R ./data/custom_ssl "$BACKUPDIR/custom_ssl"
cp -R ./data/letsencrypt-acme-challenge "$BACKUPDIR/letsencrypt-acme-challenge"