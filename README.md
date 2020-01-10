# docker-wikifarm
docker-wikifarm uses docker compose to build and manage a MediaWiki wiki farm. The wiki farm runs in two docker
containers: one for the database and one for the web server and MediaWiki.

## Files
The repo has the following directories:

### scripts

This directory contains the scripts used to build and manage the wiki farm. They include:

1. build_wikifarm.sh: build the wiki farm containers
1. clean_all.sh: remove all images and containers generated from the build and prune unused containers
1. clean.sh: remove only the database and wikifarm images and containers and prune unused containers
1. status.sh: list all images and containers
1. create_wiki.sh: create a wiki on the wikifarm
1. mk-favicon.sh: creates a favicon.ico file from the logo.png file for a wiki

### config

This directory contains files that can be edited before the wiki farm is built to specify the configuration. They include:

1. variables.env: environment variables that will be used in the containers
1. Config.php: MediaWiki configuration

### volumes

This directory contains volumes that are shared between the host and the wikifarm container. They include:

1. config: MediaWiki configuration files, including Config.php, which is copied from the config directory
1. instances: instance files for the wikis, including configuration, branding (i.e. logo and favicon), and images

### wikifarm

This directory contains the files that are necessary to build the wikifarm container.

## Building the wikifarm

To build the wikifarm, do the following:

1. Edit the files in the config directory at the top level of the repository.
2. Run the build_wikifarm.sh script from the scripts directory.

## Creating a wiki on the wikifarm

To add a new wiki to the wikifarm, do the following:

1. Run the create_wiki.sh script from the scripts directory. It takes one parameter: the name of the wiki. (Note that if you
   have just built the wiki farm, you will need to wait a few minutes to let the database come up before creating a wiki.)
1. Copy your logo file (logo.png) into the instance branding directory at `instances/<wiki name>/branding`.
1. Copy your favicon file (favicon.ico) into the instance branding directory at `instances/<wiki name>/branding` or use the
   mk-favicon.sh script to generate a favicon.ico file from your logo.png file. The latter takes one parameter: the name of
   the wiki.
1. Create a LocalSettings.php file in the `instances/<wiki name>` directory to configure the wiki instance.

