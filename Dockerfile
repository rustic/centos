# Build updated Centos with Systemd as per:
# https://registry.hub.docker.com/_/centos/
FROM centos:latest
MAINTAINER "Lee Myers" <ichilegend@gmail.com>
ENV container docker
RUN yum clean all; yum -y install hostname tar git; yum -y update; yum clean all
# https://bugzilla.redhat.com/show_bug.cgi?id=1118740
# From https://registry.hub.docker.com/u/timhughes/centos/dockerfile/
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i ==
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
