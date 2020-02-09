#!/bin/sh
$(dirname $0)/clean.sh
docker image rm -f $(docker images mediawiki -q)
docker image rm -f $(docker images mariadb -q)
docker image rm -f $(docker images php -q)
docker container prune -f
docker image prune -f
