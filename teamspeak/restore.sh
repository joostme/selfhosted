#!/bin/bash
docker compose exec -T db mariadb -u root -p"changeme" < db.sql
