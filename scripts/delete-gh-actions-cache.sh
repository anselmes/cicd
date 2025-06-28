#!/bin/bash

# SPDX-License-Identifier: GPL-3.0
# Copyright (c) 2025 Schubert Anselme <schubert@anselm.es>

gh extension install actions/gh-actions-cache

echo "Fetching list of cache key for ${REPO} in ${BRANCH}..."
CACHE_KEYS="$(gh actions-cache list -R "${REPO}" -B "${BRANCH}" | cut -f 1)"

## Setting this to not fail the workflow while deleting cache keys.
set +e
echo "Deleting caches for ${REPO} in ${BRANCH}..."
for KEY in ${CACHE_KEYS}; do
  gh actions-cache delete "${KEY}" -R "${REPO}" -B "${BRANCH}" --confirm
done
echo "Done"
