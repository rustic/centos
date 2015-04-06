FROM rustic/centos
MAINTAINER "Lee Myers" <ichilegend@gmail.com>
ENV container docker

# Install Mariadb Server and password/securing utilities
RUN yum -y install expect pwgen mariadb-server

#Start the service
RUN systemctl start mariadb

#Add script for a secure installation and set it to execute
ADD ./setup.sh /setup.sh
RUN chmod 755 /setup.sh
RUN /setup.sh

#Some cleanup
RUN yum -y remove expect pwgen

EXPOSE 3306

