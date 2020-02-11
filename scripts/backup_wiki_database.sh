#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <wiki_name>" >&2
  exit 1
fi

WIKI_NAME=$1
docker exec -it -e WIKI_NAME=${WIKI_NAME} database /root/scripts/backup_wiki_database.sh
