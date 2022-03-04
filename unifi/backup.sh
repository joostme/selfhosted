#!/bin/bash
mkdir -p backup

info "Unifi - Backup DB"
docker-compose exec -T unifi mongodump --port=27117 --archive > ./backup/unifi.archive