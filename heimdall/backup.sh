#!/bin/bash

info "Heimdall - Backup Data"
docker-compose stop
cp -R ./data ./backup
docker-compose start