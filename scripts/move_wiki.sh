#!/bin/sh
set -eu

if [ "$#" -eq 3 ]; then
	FROM_MW_VERSION=$1
	TO_MW_VERSION=$2
	WIKI_NAME=$3
	UPDATE=true
elif [ "$#" -eq 4 ] && [ "$1" = "--no-update" ]; then
	FROM_MW_VERSION=$2
	TO_MW_VERSION=$3
	WIKI_NAME=$4
	UPDATE=false
else
  echo "Usage: $0 [--no-update] <from_version> <to_version> <wiki_name>" >&2
  echo "where <from_version> and <to_version> are 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi


# disable and delete wiki apache configuration file; reload apache
docker exec -it wikifarm-${FROM_MW_VERSION} a2disconf wikifarm_${WIKI_NAME}
docker exec -it wikifarm-${FROM_MW_VERSION} rm /etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${FROM_MW_VERSION} service apache2 reload

# copy, edit, and enable wiki apache configuration file; reload apache
docker cp $(dirname $0)/../wikifarm/files/wikifarm_instance.conf wikifarm-${TO_MW_VERSION}:/etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${TO_MW_VERSION} sed -i -e "s/%%WIKI_NAME%%/${WIKI_NAME}/g" /etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${TO_MW_VERSION} a2enconf wikifarm_${WIKI_NAME}
docker exec -it wikifarm-${TO_MW_VERSION} service apache2 reload

# run update script
if [ "$UPDATE" = "true" ]; then
	docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm-${TO_MW_VERSION} php /var/www/mediawiki/maintenance/update.php --quick
fi
