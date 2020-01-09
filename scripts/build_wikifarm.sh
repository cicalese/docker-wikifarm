#!/bin/sh
if [ ! -f $(dirname $0)/../volumes/config/Config.php ]
then
	cp $(dirname $0)/../config/Config.php $(dirname $0)/../volumes/config
fi
docker-compose -f $(dirname $0)/../docker-compose.yml up -d --build
