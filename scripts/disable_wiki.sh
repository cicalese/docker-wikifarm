#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <version> <wiki_name>" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi

MW_VERSION=$1
WIKI_NAME=$2

# disable and delete wiki apache configuration file; reload apache
docker exec -it wikifarm-${MW_VERSION} a2disconf wikifarm_${WIKI_NAME}
docker exec -it wikifarm-${MW_VERSION} rm /etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${MW_VERSION} service apache2 reload
