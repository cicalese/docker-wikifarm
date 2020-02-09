#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <wiki_name> <version>" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi

WIKI_NAME=$1
MW_VERSION=$2

# run install script
docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm-${MW_VERSION} /var/www/scripts/create_wiki.sh ${WIKI_NAME}

# copy, edit, and enable wiki apache configuration file; reload apache
docker cp wikifarm/files/wikifarm_instance.conf wikifarm-${MW_VERSION}:/etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${MW_VERSION} sed -i -e "s/%%WIKI_NAME%%/${WIKI_NAME}/g" /etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm-${MW_VERSION} a2enconf wikifarm_${WIKI_NAME}
docker exec -it wikifarm-${MW_VERSION} service apache2 reload

# run update script
docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm-${MW_VERSION} php /var/www/mediawiki/maintenance/update.php --quick
