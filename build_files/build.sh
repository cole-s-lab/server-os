#!/bin/bash

set -ouex pipefail

dnf5 list installed

dnf5 remove -y \
  moby-engine \
  docker-compose

dnf5 install -y \
  podman-compose \
  podman-docker

dnf5 config-manager addrepo \
  --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 install -y tailscale

systemctl enable podman.socket
systemctl enable tailscale.socket
