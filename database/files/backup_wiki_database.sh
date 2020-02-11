#!/bin/sh

if [ -z "$WIKI_NAME" ] 
then
	echo '$WIKI_NAME is not set.'
	exit 1
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]
then
	echo '$MYSQL_ROOT_PASSWORD is not set.'
	exit 1
fi

DUMP_FILE=${WIKI_NAME}-`date "+%Y%m%d%H%M%S"`.sql
echo "Backing up $WIKI_NAME to volumes/backups/$DUMP_FILE"

mysqldump -u root --password=$MYSQL_ROOT_PASSWORD $WIKI_NAME > /root/backups/$DUMP_FILE
