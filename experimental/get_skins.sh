#!/bin/bash
set -eu

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <version>" >&2
	echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
	exit 1
fi

MW_VERSION=$1
MW_DIR="/var/www/mediawiki"

GIT_RELEASE_BRANCH_SKINS=(

	# bundled skins
	"MonoBook"
	"Timeless"
)

GIT_MASTER_SKINS=(
)

COMPOSER_SKINS=(
	"mediawiki/chameleon-skin:2.1.0"
)

GIT_URL="https://gerrit.wikimedia.org/r/mediawiki/skins/"

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

if [ "${#GIT_RELEASE_BRANCH_SKINS[@]}" -gt 0 ]; then
	for i in "${GIT_RELEASE_BRANCH_SKINS[@]}"
	do
		echo $i
		docker exec -it -w ${MW_DIR}/skins wikifarm-${MW_VERSION} sh -c "if [ ! -d \"$i\" ]; then git clone ${GIT_URL}/${i}.git --branch ${MW_BRANCH}; fi"
	done
fi

if [ "${#GIT_MASTER_SKINS[@]}" -gt 0 ]; then
	for i in "${GIT_MASTER_SKINS[@]}"
	do
		echo $i
		docker exec -it -w ${MW_DIR}/skins wikifarm-${MW_VERSION} sh -c "if [ ! -d \"$i\" ]; then git clone ${GIT_URL}/${i}.git; fi"
	done
fi

if [ "${#COMPOSER_SKINS[@]}" -gt 0 ]; then
	for i in "${COMPOSER_SKINS[@]}"
	do
		echo $i
		docker exec -it -w ${MW_DIR} wikifarm-${MW_VERSION} sh -c "composer require $i"
	done
fi
