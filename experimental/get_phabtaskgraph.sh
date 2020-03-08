#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <version>" >&2
	echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
	exit 1
fi

MW_VERSION=$1
MW_DIR="/var/www/mediawiki"

GIT_URL="https://gerrit.wikimedia.org/r/mediawiki/extensions/"

case $MW_VERSION in
	1.31)
		MW_BRANCH=REL1_31
		;;
	1.32)
		MW_BRANCH=REL1_32
		;;
	1.33)
		MW_BRANCH=REL1_33
		;;
	1.34)
		MW_BRANCH=REL1_34
		;;
	*)
		MW_BRANCH=master
		;;
esac

docker exec -it -w ${MW_DIR}/extensions wikifarm-${MW_VERSION} sh -c "if [ ! -d \"PhabTaskGraph\" ]; then git clone ${GIT_URL}/PhabTaskGraph.git; fi"
docker exec -it wikifarm-${MW_VERSION} sh -c "apt update; apt install libphutil"
