#!/bin/sh
set -eu
docker exec -it database sh -c "mysql -u root -p"
