#!/bin/bash

info "Tandoor - Restore Recipes"
cat ./backup/tandoor.sql | docker-compose exec -T db_recipes psql -U djangouser djangodb

info "Tandoor - Backup Images"
cp -R ./backup/media/* ./data/media/