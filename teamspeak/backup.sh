rm -rf ./data/mariadb/backup
docker compose exec db mariadb-dump --all-databases -u root -p"changeme" > db.sql
