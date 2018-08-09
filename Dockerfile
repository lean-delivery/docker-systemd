FROM centos:7

LABEL maintainer="team@lean-delivery.com"

ENV container docker \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum makecache fast && yum update -y && \
    INSTALL_PKGS="initscripts systemd-sysv redhat-lsb-core sudo bash iproute yum-plugin-ovl" && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    sed -i 's/plugins=0/plugins=1/g' /etc/yum.conf && \
    yum clean all && rm -rf /var/cache/yum && \
    touch /etc/sysconfig/network && \    
    localedef -f UTF-8 -i en_US en_US.UTF-8

VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/usr/sbin/init"]