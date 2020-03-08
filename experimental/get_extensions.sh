#!/bin/bash
set -eu

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <version>" >&2
	echo "where <version> is 1.31, 1.32, 1.33, 1.34, or master" >&2
	exit 1
fi

MW_VERSION=$1
MW_DIR="/var/www/mediawiki"

GIT_RELEASE_BRANCH_EXTENSIONS=(

	# bundled extensions
	"CategoryTree"
	"Cite"
	"CiteThisPage"
	"CodeEditor"
	"ConfirmEdit"
	"Gadgets"
	"ImageMap"
	"InputBox"
	"Interwiki"
	"LocalisationUpdate"
	"MultimediaViewer"
	"Nuke"
	"OATHAuth"
	"PageImages"
	"ParserFunctions"
	"PdfHandler"
	"Poem"
	"Renameuser"
	"ReplaceText"
	"Scribunto"
	"SpamBlacklist"
	"SyntaxHighlight_GeSHi"
	"TextExtracts"
	"TitleBlacklist"
	"WikiEditor"

	# other release branch extensions
	"Echo"
	"HeaderTabs"
	"PipeEscape"
	"Variables"
	"UrlGetParameters"
)

GIT_MASTER_EXTENSIONS=(
	"Arrays"
	"Cargo"
	"CommentStreams"
	"DisplayTitle"
	"EmailAuthorization"
	"ExternalData"
	"JSBreadCrumbs"
	"MagicNoCache"
	"OpenIDConnect"
	"PageForms"
	"PluggableAuth"
	"SimpleSAMLphp"
	"TitleIcon"
)

COMPOSER_EXTENSIONS=(
	"mediawiki/semantic-media-wiki:3.1.5"
	"mediawiki/semantic-result-formats:3.1.0"
	"mediawiki/semantic-extra-special-properties:2.1.0"
	"mediawiki/semantic-scribunto:2.1.0"
	"mediawiki/mermaid:2.2.0"
	"mediawiki/user-functions:2.7.0"
)

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

for i in "${GIT_RELEASE_BRANCH_EXTENSIONS[@]}"
do
	echo $i
	docker exec -it -w ${MW_DIR}/extensions wikifarm-${MW_VERSION} sh -c "if [ ! -d \"$i\" ]; then git clone ${GIT_URL}/${i}.git --branch ${MW_BRANCH}; fi"
done

for i in "${GIT_MASTER_EXTENSIONS[@]}"
do
	echo $i
	docker exec -it -w ${MW_DIR}/extensions wikifarm-${MW_VERSION} sh -c "if [ ! -d \"$i\" ]; then git clone ${GIT_URL}/${i}.git; fi"
done

for i in "${COMPOSER_EXTENSIONS[@]}"
do
	echo $i
	docker exec -it -w ${MW_DIR} wikifarm-${MW_VERSION} sh -c "composer require $i"
done
