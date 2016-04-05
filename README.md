# docker-centreon-server
Centreon server + pollor

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

