#!/bin/bash

function info {
  printf "\n%s %s\n\n" "$( date )" "$*" >&2;
}

cwd=`pwd`;
BACKUP_BASE_DIR="$cwd/backup"
rm -rf "$BACKUP_BASE_DIR"
mkdir "$BACKUP_BASE_DIR"

export DOCKER_HOST=unix:///run/user/1000/docker.sock

for backupscript in **/backup.sh; do
    cd `dirname $backupscript`
    . `basename $backupscript`
    cd $cwd
done