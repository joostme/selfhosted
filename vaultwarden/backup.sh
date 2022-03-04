#!/bin/bash
mkdir -p backup

info "Vault - Backup DB"
sqlite3 ./data/db.sqlite3 ".backup './backup/vault.sqlite3'"

info "Vault - Backup config"
cp -R ./data/attachments ./backup/attachments
cp -R ./data/sends ./backup/sends
cp ./data/config.json ./backup/config.json
cp ./data/rsa_key.* ./backup/
