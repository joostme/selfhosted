#!/bin/bash
mkdir -p backup

info "Monica - Backup OAuth Keys"
cp ./data/www/oauth-*.key ./backup/

info "Monica - Backup DB"
docker-compose exec db /usr/bin/mysqldump -u root --password=secret monica > backup/monica.sql