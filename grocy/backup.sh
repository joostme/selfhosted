#!/bin/bash

info "Grocy - Backup Data"
docker-compose stop
cp -R ./data ./backup
docker-compose start