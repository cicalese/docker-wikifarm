#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <version>" >&2
  echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
  exit 1
fi

MW_VERSION=$1

docker exec -it wikifarm-${MW_VERSION} bash
