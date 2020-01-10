#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 WIKI_NAME" >&2
  exit 1
fi

WIKI_NAME=$1

# run install script
docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm /var/www/scripts/create_wiki.sh ${WIKI_NAME}

# copy, edit, and enable wiki apache configuration file; reload apache
docker cp wikifarm/files/wikifarm_instance.conf wikifarm:/etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm sed -i -e "s/%%WIKI_NAME%%/${WIKI_NAME}/g" /etc/apache2/conf-available/wikifarm_${WIKI_NAME}.conf
docker exec -it wikifarm a2enconf wikifarm_${WIKI_NAME}
docker exec -it wikifarm service apache2 reload

# run update script
docker exec -it -e WIKI_NAME=${WIKI_NAME} wikifarm php /var/www/mediawiki/maintenance/update.php --quick
