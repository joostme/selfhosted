#!/bin/bash

info "AdGuard - Restore Config"
docker-compose stop
cp ./backup/AdGuardHome.yaml ./data/conf/AdGuardHome.yaml
docker-compose start