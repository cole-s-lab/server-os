#!/bin/bash

set -ouex pipefail

# Remove packages
dnf5 remove -y \
  docker-cli \
  moby-engine

# Install packages
dnf5 install -y \
  iptables-services

dnf5 install -y \
  podman-compose \
  podman-docker

systemctl disable firewalld

systemctl enable podman.socket
systemctl enable podman-restart.service
systemctl enable iptables.service
