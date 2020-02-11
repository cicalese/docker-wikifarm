#!/bin/sh

if [ -z "$WIKI_NAME" ] 
then
	echo '$WIKI_NAME is not set.'
	exit 1
fi

if [ -z "$MEDIAWIKI_WIKI_ADMIN_USER" ]
then
	echo '$MEDIAWIKI_WIKI_ADMIN_USER is not set.'
	exit 1
fi

if [ -z "$MEDIAWIKI_WIKI_ADMIN_PASSWORD" ]
then
	echo '$MEDIAWIKI_WIKI_ADMIN_PASSWORD is not set.'
	exit 1
fi

if [ ${#MEDIAWIKI_WIKI_ADMIN_PASSWORD} -lt 10 ]
then
	echo '$MEDIAWIKI_WIKI_ADMIN_PASSWORD must be at least 10 characters in length.'
	exit 1
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]
then
	echo '$MYSQL_ROOT_PASSWORD is not set.'
	exit 1
fi

php /root/scripts/create_wiki.php ${WIKI_NAME} ${MEDIAWIKI_WIKI_ADMIN_USER} \
  --pass ${MEDIAWIKI_WIKI_ADMIN_PASSWORD} \
  --dbuser root \
  --dbpass ${MYSQL_ROOT_PASSWORD} \
  --installdbuser root \
  --installdbpass ${MYSQL_ROOT_PASSWORD} \
  --dbname ${WIKI_NAME} \
  --dbserver database

if [ ! -d /var/www/wikifarm/instances/${WIKI_NAME} ]
then
	mkdir /var/www/wikifarm/instances/${WIKI_NAME}
	mkdir /var/www/wikifarm/instances/${WIKI_NAME}/branding
	mkdir /var/www/wikifarm/instances/${WIKI_NAME}/images
	chown -R www-data:www-data /var/www/wikifarm/instances/${WIKI_NAME}
fi
