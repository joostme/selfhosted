#!/bin/bash

info "Vault - Restore DB"
sqlite3 ./data/db.sqlite3 ".restore './backup/vault.sqlite3'"

info "Vault - Restore config"
cp -R ./backup/attachments ./data/attachments
cp -R ./backup/sends ./data/sends
cp ./backup/config.json ./data/config.json
cp ./backup/rsa_key.* ./data/
