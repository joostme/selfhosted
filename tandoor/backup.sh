#!/bin/bash
mkdir -p backup

info "Tandoor - Backup Recipes"
docker-compose exec -T db_recipes pg_dumpall -U djangouser > ./backup/tandoor.sql

info "Tandoor - Backup Images"
cp -R ./data/media ./backup/media