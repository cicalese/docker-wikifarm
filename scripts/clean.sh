#!/bin/sh
docker container rm -f wikifarm database
docker image rm -f wikifarm
docker container prune -f
docker image prune -f
