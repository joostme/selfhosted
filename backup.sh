#!/bin/bash

function info {
  printf "\n%s %s\n\n" "$( date )" "$*" >&2;
}

cwd=`pwd`;

for backupscript in **/backup.sh; do
    cd `dirname $backupscript`
    . `basename $backupscript`
    cd $cwd
done