#!/bin/bash
mkdir -p backup

info "Paperless - Backup Documents"
docker-compose exec -T webserver document_exporter ../export
cp -R ./export ./backup