# syntax=docker/dockerfile:1.7.0
# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>
# SPDX-Licence-Identifier: GPL-3.0

ARG BASE_IMAGE=ubuntu:24.04
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
#!/bin/bash

apt-get update -yq
apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  git \
  gnupg2 \
  sudo \
  zsh

chsh -s "$(command -v zsh)" "ubuntu"

echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/ubuntu
chmod 0440 /etc/sudoers.d/ubuntu

groups=(docker libvirt plugdev sudo)
for g in "${groups[@]}"; do
  usermod -aG "${g}" "ubuntu"
done

rm -rf /var/lib/apt/lists/*
EOF

USER ubuntu
CMD ["/bin/bash"]
