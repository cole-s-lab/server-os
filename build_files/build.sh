#!/bin/bash

set -ouex pipefail

dnf5 remove -y \
  docker-cli \
  moby-engine

dnf5 install -y \
  podman-compose \
  podman-docker

systemctl enable podman.socket
