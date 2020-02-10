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
if [ ! -f $(dirname $0)/../volumes/config/${1}/Config.php ]
then
	if [ ! -d $(dirname $0)/../volumes/config/${1} ]
	then
		mkdir $(dirname $0)/../volumes/config/${1}
	fi
	cp $(dirname $0)/../config/Config.php $(dirname $0)/../volumes/config/${1}
fi
MW_PORT=$MW_PORT docker-compose -f $(dirname $0)/../docker-compose-${1}.yml up -d --build
