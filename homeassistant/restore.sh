#!/bin/bash

info "Homeassistant - Restore Data"
docker-compose stop
rm -rf ./data
cp -R ./backup ./data 
docker-compose start