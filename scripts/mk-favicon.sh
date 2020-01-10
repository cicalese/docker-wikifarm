#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 WIKI_NAME" >&2
  exit 1
fi

WIKI_NAME=$1

docker exec -it -e WIKI_NAME=${WIKI_NAME} -w /var/www/wikifarm/instances/${WIKI_NAME}/branding wikifarm /var/www/scripts/mk-favicon.sh ${WIKI_NAME}
