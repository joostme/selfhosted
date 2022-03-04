#!/bin/bash

info "Homeassistant - Backup Data"
docker-compose stop
cp -R ./data ./backup
docker-compose start