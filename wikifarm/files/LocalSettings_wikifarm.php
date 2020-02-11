<?php
# DO NOT MODIFY THIS FILE
#
# To change the value of a global configuration variable, edit
# /var/www/wikifarm/config/Config.php.
#
# To run maintenance scripts from the command line against this wiki, you
# must first set the WIKI_NAME environment variable. You can do so with the
# command:
#   export WIKI_NAME=<wikiname>
# where <wikiname> is the name of the wiki you want to work with.
# Or you can set the variable on the command line, e.g.
#   WIKI_NAME=<wikiname> php maintenance/update.php

if ( !defined( 'MEDIAWIKI' ) ) {
	exit;
}

# Make sure the required server and environment variables are set
$requiredSrvVars = [
	'WIKI_NAME',
];
foreach ( $requiredSrvVars as $var ) {
	if ( !isset( $_SERVER[$var] ) ) {
		die( $var . " is not set." . PHP_EOL );
	}
}
$requiredEnvVars = [
	'MYSQL_ROOT_PASSWORD',
	'MEDIAWIKI_WIKIFARM_BASE_URL_NO_PORT'
];
foreach ( $requiredEnvVars as $var ) {
	if ( !isset( $_ENV[$var] ) ) {
		die( $var . " is not set." . PHP_EOL );
	}
}

$wgSitename = $_SERVER['WIKI_NAME'];
$wgMetaNamespace = $wgSitename;
$wgScriptPath = "/$wgSitename";
$wgResourceBasePath = $wgScriptPath;
$wgServer = $_ENV['MEDIAWIKI_WIKIFARM_BASE_URL_NO_PORT'];
if ( isset( $_ENV['MEDIAWIKI_PORT'] ) ) {
	$wgServer = $wgServer . ':' . $_ENV['MEDIAWIKI_PORT'];
}

$wgDBtype = "mysql";
$wgDBserver = "database";
$wgDBname = $wgSitename;
$wgDBuser = "root";
$wgDBpassword = $_ENV['MYSQL_ROOT_PASSWORD'];
$wgDBprefix = "";
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=binary";

$INSTANCE_DIR = "/var/www/wikifarm/instances/" . $wgSitename;
if( file_exists( "$INSTANCE_DIR/branding/logo.png" ) ) {
  $wgLogo = "$wgServer/$wgSitename/branding/logo.png";
} else {
  $wgLogo = "$wgResourceBasePath/resources/assets/wiki.png";
}
if( file_exists( "$INSTANCE_DIR/branding/favicon.ico" ) ) {
  $wgFavicon = "$wgServer/$wgSitename/branding/favicon.ico";
}

require_once( "/var/www/wikifarm/Keys.php" );
require_once( "/var/www/wikifarm/config/Config.php" );

if( file_exists( "$INSTANCE_DIR/LocalSettings.php" ) ) {
	require_once( "$INSTANCE_DIR/LocalSettings.php" );
}
