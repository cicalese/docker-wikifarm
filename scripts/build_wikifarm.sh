#!/bin/sh
set -eu

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <version> [<port>]" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi
if [ "$#" -lt 2 ]; then
	MW_PORT=80
else
	MW_PORT=$2
fi
MW_PORT=$MW_PORT docker-compose -f $(dirname $0)/../docker-compose-${1}.yml up -d --build
docker cp wikifarm-${1}:/var/www/mediawiki/extensions volumes/mediawiki/${1}
docker exec -it wikifarm-${1} rm -rf /var/www/mediawiki/extensions
docker exec -it wikifarm-${1} ln -s /var/www/wikifarm/extensions /var/www/mediawiki/extensions
docker cp wikifarm-${1}:/var/www/mediawiki/skins volumes/mediawiki/${1}
docker exec -it wikifarm-${1} rm -rf /var/www/mediawiki/skins
docker exec -it wikifarm-${1} ln -s /var/www/wikifarm/skins /var/www/mediawiki/skins
cp wikifarm/files/Config.php volumes/mediawiki/${1}/config
cp wikifarm/files/WikiFarmSkins.php volumes/mediawiki/${1}/config
cp wikifarm/files/WikiFarmExtensions.php volumes/mediawiki/${1}/config

