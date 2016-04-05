
FROM c4tech/c4-centreon-server:install
MAINTAINER jeffrey Brite <jeff@c4tech.com>

# remove install dir
RUN rm -R /usr/share/centreon/www/install

# Install centreon poller
RUN yum -y install centreon-poller-centreon-engine

# Install ssh
RUN yum -y install openssh-server openssh-client
