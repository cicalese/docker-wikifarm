<?php
# Edit this file to modify configuration variables.
# This file is included by /var/www/wikifarm/LocalSettings.php, which
# should NOT be edited.

## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

$wgEmergencyContact = "apache@localhost";
$wgPasswordSender = "apache@localhost";

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Shared memory settings
$wgMainCacheType = CACHE_ACCEL;
$wgMemCachedServers = [];

## Image uploads
$wgEnableUploads = true;
$wgUploadPath = "$wgScriptPath/img_auth.php";
$wgImgAuthPublicTest = false;
$wgUploadDirectory = "$INSTANCE_DIR/images";
$wgTmpDirectory = "$INSTANCE_DIR/images/temp";
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

# Periodically send a pingback to https://www.mediawiki.org/ with basic data
# about this MediaWiki instance. The Wikimedia Foundation shares this data
# with MediaWiki developers to help guide future development efforts.
$wgPingback = false;

## If you use ImageMagick (or any other shell command) on a
## Linux server, this will need to be set to the name of an
## available UTF-8 locale
$wgShellLocale = "C.UTF-8";

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publicly accessible from the web.
#$wgCacheDirectory = "$IP/cache";

# Site language code, should be one of the list in ./languages/data/Names.php
$wgLanguageCode = "en";

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

$wgGroupPermissions['*']['read'] = true;
$wgGroupPermissions['*']['edit'] = false;

# Debugging - uncomment to enable debugging
#error_reporting( -1 );
#ini_set( 'display_errors', 1 );
#$wgResourceLoaderDebug = true;
#$wgShowDBErrorBacktrace = true;
#$wgDebugLogFile= "/tmp/MediaWikiDebug.log";
#$wgDebugDumpSql = true;
#$wgShowSQLErrors = true;
#$wgShowExceptionDetails = true;
#$wgEnableJavaScriptTest = true;
