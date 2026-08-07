#!/bin/bash

# SPDX-License-Identifier: GPL-3.0
# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>

RUNNER_OS="linux"
RUNNER_VERSION="2.294.0"
RUNNER_HASH_256="11041376754f6beaccb56101a3e79bf5fc5d6ff628460fa1ae419f9f439e24a2"

##
## Download
##

# Create a folder
mkdir actions-runner && cd actions-runner || exit

# Download the latest runner package
curl \
  -o "actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz" \
  -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz"

# Optional: Validate the hash
echo "${RUNNER_HASH_256}  actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf "./actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz"

##
## Configure
##

# Create the runner and start the configuration experience
./config.sh --url https://github.com/anselmes/images --token "${GH_TOKEN}"

# Last step, run it!
echo """
# Use this YAML in your workflow file for each job
runs-on: self-hosted
"""

# Configure to run as a service
./svc.sh install
./svc.sh start
./svc.sh status
