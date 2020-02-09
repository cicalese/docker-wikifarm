#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <wiki_name> <version>" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi

WIKI_NAME=$1
MW_VERSION=$2

docker exec -it -e WIKI_NAME=${WIKI_NAME} -w /var/www/wikifarm/instances/${WIKI_NAME}/branding wikifarm-${MW_VERSION} /var/www/scripts/mk-favicon.sh ${WIKI_NAME}