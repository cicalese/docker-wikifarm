FROM mediawiki:latest AS wikifarm

WORKDIR /var/www/wikifarm
COPY files/LocalSettings_wikifarm.php /var/www/wikifarm/LocalSettings.php
COPY files/Keys.php /var/www/wikifarm/Keys.php
RUN sed -i -e "s/%%SECRET_KEY%%/`od -N 32 -An -vx  /dev/urandom | tr '\n' ' ' | sed -e 's/ //g'`/" /var/www/wikifarm/Keys.php

RUN mv /var/www/html /var/www/mediawiki
COPY files/LocalSettings_mediawiki.php /var/www/mediawiki/LocalSettings.php

RUN mkdir /var/www/html
COPY files/index.php /var/www/html

RUN mkdir /var/www/scripts
COPY files/create_wiki.sh /var/www/scripts
COPY files/create_wiki.php /var/www/scripts

RUN a2disconf short-url

COPY files/wikifarm.conf /etc/apache2/conf-available
RUN a2enconf wikifarm

RUN service apache2 restart
