FROM ubuntu:18.04

LABEL maintainer="team@lean-delivery.com"

ENV container docker \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -print0 | xargs -0 rm -vf

RUN apt-get update && \
    INSTALL_PKGS="python sudo bash apt-utils locales ca-certificates dbus systemd" && \
    apt-get install -y $INSTALL_PKGS && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -f UTF-8 -i en_US en_US.UTF-8

STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/sbin/init"]