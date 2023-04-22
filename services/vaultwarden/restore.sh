#!/bin/bash
BACKUPDIR="$BACKUP_BASE_DIR/vaultwarden"

info "Vault - Restore DB"
sqlite3 ./data/db.sqlite3 ".restore '$BACKUPDIR/vault.sqlite3'"

info "Vault - Restore config"
cp -R "$BACKUPDIR/attachments" ./data/attachments
cp -R "$BACKUPDIR/sends" ./data/sends
cp "$BACKUPDIR/config.json" ./data/config.json
cp $BACKUPDIR/rsa_key.* ./data/
