# Build updated Centos with Systemd as per:
# https://registry.hub.docker.com/_/centos/
FROM centos:latest
MAINTAINER "Lee Myers" <ichilegend@gmail.com>
ENV container docker
RUN yum clean all; yum -y install hostname tar git; yum -y update; yum clean all
# https://bugzilla.redhat.com/show_bug.cgi?id=1118740
# From https://registry.hub.docker.com/u/timhughes/centos/dockerfile/
RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs
RUN yum -y update; yum clean all; 
