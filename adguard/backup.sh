#!/bin/bash

info "AdGuard - Backup Config"
docker-compose stop
mkdir -p backup
cp ./data/conf/AdGuardHome.yaml ./backup/
docker-compose start