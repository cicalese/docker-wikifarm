#!/bin/sh
docker container rm -f wikifarm-1.31
docker container rm -f wikifarm-1.32
docker container rm -f wikifarm-1.33
docker container rm -f wikifarm-1.34
docker container rm -f wikifarm-master
docker container rm -f database
docker image rm -f wikifarm-1.31
docker image rm -f wikifarm-1.32
docker image rm -f wikifarm-1.33
docker image rm -f wikifarm-1.34
docker image rm -f wikifarm-master
docker image rm -f database
docker container prune -f
docker image prune -f
