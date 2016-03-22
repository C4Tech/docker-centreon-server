# TODO
# need to create an imstall image and a prodcution image
# figure out where the volumes go


FROM centos:centos6.6
MAINTAINER jeffrey Brite <jeff@c4tech.com>

# Update CentOS
RUN yum -y update

RUN yum -y install wget
# Install Centreon Repository
RUN yum -y install http://yum.centreon.com/standard/3.0/stable/noarch/RPMS/ces-release-3.0-1.noarch.rpm

# Install centreon
RUN yum -y install centreon-base-config-centreon-engine centreon
# Install Widgets
RUN yum -y install centreon-widget-graph-monitoring centreon-widget-host-monitoring centreon-widget-service-monitoring centreon-widget$

# Dirty - need to figure out how to have it set by an environmental var or something.
RUN sed -i "s/;date.timezone =.*/date.timezone = America\/Chicago/" /etc/php.ini

# Set rights for setuid RUN chown root:centreon-engine /usr/lib/nagios/plugins/check_icmp
RUN chmod -w /usr/lib/nagios/plugins/check_icmp
RUN chmod u+s /usr/lib/nagios/plugins/check_icmp

# remove install dir
RUN rm -R /usr/share/centreon/www/install

# Install and configure supervisor
RUN yum -y install python-setuptools
RUN easy_install supervisor

# Todo better split file
ADD scripts/supervisord.conf /etc/supervisord.conf

# Expose port HTTP for the service
EXPOSE 80

CMD ["/usr/bin/supervisord","--configuration=/etc/supervisord.conf"]
