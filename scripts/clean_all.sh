#!/bin/sh
docker container rm -f wikifarm database
docker image rm -f wikifarm mediawiki mariadb
docker container prune -f
docker image prune -f
