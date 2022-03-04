#!/bin/bash

info "Gotify - Backup Data"
docker-compose stop
cp -R ./data ./backup
docker-compose start