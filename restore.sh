#!/bin/bash

service=$1

function info {
  printf "\n%s %s\n\n" "$( date )" "$*" >&2;
}

cwd=`pwd`;
BACKUP_BASE_DIR="$cwd/backup"

cd "$cwd/$service"
. `basename restore.sh`