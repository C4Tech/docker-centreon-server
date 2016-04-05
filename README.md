# docker-centreon-server
Centreon server + pollor

*Current Status*
if you follow the how-to, you should get a working Centreon server and poller. I'm about to put this in production and will let everyone know how it goes. Please let me know if you have suggestions on how to improve this. If this goes well, I'll start work on the standalone pollers.


I borrowed julienmathis setup https://hub.docker.com/r/julienmathis/centreon-docker/

Howto
* you need a mysql or mariadb docker
* use "install" tag for first run
* run through centreon setup
* grab conf.pm and centreon.conf.php for next phase (I created a volume on the container 
      and used docker exec commands to copy to to the volume after. locations are 
      /etc/centreon/centreon.conf.php and /etc/centreon/conf.pm
* delete container
* create a new contrainer without "install tage"
* setup volumes on container with the centreon.conf.php and conf.pm
* setup a volume for /var/spool/centreon/.ssh/
* create a ssh rsa key there. ssh-keygen
* copy id_rsa.pub to authorized_keys so that the "server" can ssh into itself to manage the "poller"

TODOs
* create a better howto
* create a centreon server image without a pollor
* create a centreon pollor image
* improve "install" image
* have to figure out a way to have uploaded images saved between contain removes

*my docker-compose*
NOTE: I use a nginx-proxy with letsencrypt docker container to handle the ssl. see c4tech/nginx-proxy-ldap-auth and jrcs/letsencrypt-nginx-proxy-companion for more information on that

centreon-db:
  image: mariadb
  expose:
    - 3306
  volumes:
    - ./centreon/db:/var/lib/mysql
  env_file: 
    - ./centreon/centreon-db.env
  restart: always

centreon:
  image: c4tech/c4-centreon-server
  links:
    - centreon-db
  expose:
    - 80
  volumes:
    - ./centreon/data/centreon.conf.php:/etc/centreon/centreon.conf.php
    - ./centreon/data/conf.pm:/etc/centreon/conf.pm
    - ./centreon/data/dotssh/:/var/spool/centreon/.ssh/
  env_file:
    - ./centreon/centreon.env
  restart: always
