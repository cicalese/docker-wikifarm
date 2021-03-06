#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <version> <wiki_name>" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi

MW_VERSION=$1
WIKI_NAME=$2

# run update script
docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm-${MW_VERSION} php /var/www/mediawiki/maintenance/update.php --quick
