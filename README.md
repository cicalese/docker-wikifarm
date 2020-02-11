# docker-wikifarm
docker-wikifarm uses docker compose to build and manage a MediaWiki wiki farm.
The wiki farm runs in two docker containers: one for the database and one for
the web server and MediaWiki.

## Files
The repo has the following directories:

### scripts

This directory contains the scripts used to build and manage the wiki farm.
They include:

1. `build_wikifarm.sh`: build the wiki farm containers for one MediaWiki
version (1.31, 1.32, 1.33, 1.34, or master)
1. `build_all.sh`: build the wiki farm containers for all supported
MediaWiki versions
1. `create_wiki.sh`: create a wiki on the wikifarm
1. `mk-favicon.sh`: creates a `favicon.ico` file from the `logo.png` file for
a wiki
1. `move_wiki.sh`: move a wiki from one wiki farm container to another
1. `backup_wiki_database.sh`: create a SQL dump of a wiki in `volumes/backups`
1. `disable_wiki`: disable a wiki on a wiki farm (this does not remove the
database)
1. `run_update.sh`: run the update maintenance script on one wiki
1. `status.sh`: list all images and containers
1. `clean_all.sh`: remove all images and containers generated from the build
and prune unused containers
1. `clean.sh`: remove only the database and wikifarm images and containers and
prune unused containers
1. `wiki_shell.sh`: open a bash command prompt on a wiki farm
1. `database_shell.sh`: open a MySQL shell on the database host

### config

This directory contains files that can be edited before the wiki farm is built
to specify the configuration. They include:

1. `variables.env`: environment variables that will be used in the containers
1. `Config.php`: MediaWiki configuration

### volumes

This directory contains volumes that are shared between the host and the
wikifarm container. They include:

1. `config`: MediaWiki configuration files, including `Config.php`, which is
copied from the `config` directory to the `volumes/config` directory by
build_wikifarm.sh
1. `instances`: instance files for the wikis, including configuration, branding
(i.e. logo and favicon), and images
1. `extensions`: the extensions directory, allowing management of extensions
on the host
1. `backups`: wiki SQL dumps created by the `backup_wiki_database.sh` script 

### wikifarm

This directory contains the files that are necessary to build the wikifarm
container.

## Building the wikifarm

To build the wikifarm, do the following:

1. Edit the files in the `config` directory at the top level of the repository.
Especially change the passwords in `config/variables.env`.
1. Run the `build_wikifarm.sh` script that is in the scripts directory. It
takes two parameters: the MediaWiki version (i.e. 1.31, 1.32, 1.33, 1.34, or
master) and the host port to use to communicate with the wiki farm web server.

## Creating a wiki on the wikifarm

To add a new wiki to the wikifarm, do the following:

1. Run the `create_wiki.sh` script from the scripts directory. It takes two
parameters: the name of the wiki and the MediaWiki version of the wiki farm
(i.e. 1.31, 1.32, 1.33, 1.34, or master). (Note that if you have just built
the wiki farm, you will need to wait a few minutes to let the database come up
before creating a wiki.)
1. Copy the logo file (`logo.png`) into the instance branding directory at
`volumes/instances/<wiki name>/branding`.
1. Copy your favicon file (`favicon.ico`) into the instance branding directory
at `volumes/instances/<wiki name>/branding` or use the `mk-favicon.sh` script
to generate a `favicon.ico` file from your `logo.png` file. The latter takes
two parameters: the name of the wiki and the MediaWiki version of the wiki
farm.
1. Create a `LocalSettings.php` file in the `volumes/instances/<wiki name>`
directory to configure the wiki instance. The instance `LocalSettings.php` file
will be called from the end of the wiki farm `LocalSettings.php` file. The
content of the latter file can be examined at
'wikifarm/files/LocalSettings_wikifarm.php`.
