# TODO
# need to create an imstall image and a prodcution image
# figure out where the volumes go


FROM c4tech/c4-centreon-server:install
MAINTAINER jeffrey Brite <jeff@c4tech.com>

# remove install dir
RUN rm -R /usr/share/centreon/www/install
