#!/bin/bash

info "Paperless - Restore Documents"
cp -R ./backup/* ./export
docker-compose exec -T webserver document_importer ../export