# docker-systemd
Docker images with systemd support

A Docker images based on `ubuntu`, `centos` that runs `systemd` with a minimal set of services.

**This image is meant for development use only. We strongly recommend against
running it in production!**

## Supported tags

ubuntu:
* `ubuntu-18.04`
* `ubuntu-16.04`

centos:
* `centos7`

## Aim

These images were created for using with molecule tool when do testing with docker driver.

To start a service which requires systemd, configure molecule.yml with a systemd compliant image, capabilities, volumes, and command as follows.

```yml
- name: test-instance-centos
    image: leandelivery/docker-systemd:centos7
    privileged: True
    security_opts:
      - seccomp=unconfined
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    tmpfs:
      - /tmp
      - /run
    capabilities:
      - SYS_ADMIN
    groups:
      - rhel_family

- name: test-instance-ubuntu
    image: leandelivery/docker-systemd:ubuntu-18.04
    privileged: True
    security_opts:
      - seccomp=unconfined
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    tmpfs:
      - /tmp
      - /run
    capabilities:
      - SYS_ADMIN
    groups:
      - debian_family
```

## Branching strategy

By default, Docker builds images for each branch in your repository. It assumes the Dockerfile lives at the root of your source. When it builds an image, Docker tags it with the branch name.

We use default behaviour.

License
-------

Apache2

Author Information
------------------

authors:
  - Lean Delivery <team@lean-delivery.com>
