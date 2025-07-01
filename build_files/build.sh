#!/bin/bash

set -ouex pipefail

dnf5 remove -y \
  moby-engine \
  docker-compose

dnf5 install -y \
  podman-compose \
  podman-docker

systemctl enable podman.socket
