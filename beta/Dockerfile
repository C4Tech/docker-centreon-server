FROM c4tech/c4-centreon-server
MAINTAINER jeffrey Brite <jeff@c4tech.com>

# Install centreon poller
RUN yum -y install centreon-poller-centreon-engine

# Install ssh
RUN yum -y install openssh-server openssh-client
CMD if [ ! -f /var/spool/centreon/.ssh/id_rsa ]; then su centreon -c 'ssh-keygen -t rsa -f /var/spool/centreon/.ssh/id_rsa -q -N ""'; fi
CMD cp /var/spool/centreon/.ssh/id_rsa /var/spool/centreon/.ssh/authorized_keys
