#!/bin/bash

info "Monica - Restore OAuth Keys"
cp ./backup/oauth-*.key ./data/www/

info "Monica - Restore DB"
cat backup/monica.sql | docker-compose exec -T db /usr/bin/mysql -u root --password=secret monica 