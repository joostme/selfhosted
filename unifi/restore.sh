#!/bin/bash

info "Unifi - Backup DB"
cat ./backup/unifi.archive | docker-compose exec -T unifi mongorestore --port=27117 --archive 