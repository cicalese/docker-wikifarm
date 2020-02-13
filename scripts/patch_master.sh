#!/bin/sh
set -eu

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <patch_num> <wiki_name>*" >&2
  echo "where <patch_num> is the number of the core patch in gerrit" >&2
  exit 1
fi

PATCH_NUM=$1
shift

docker exec -it -w /var/www/mediawiki wikifarm-master git review -d $PATCH_NUM
docker exec -it -w /var/www/mediawiki wikifarm-master php /usr/local/composer/composer.phar update --no-dev
while [ $# -gt 0 ]
do
	docker exec -it -w /var/www/mediawiki -e WIKI_NAME=$1 wikifarm-master php maintenance/update.php --quick
	shift
done
