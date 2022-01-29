#!/usr/bin/env bash

# make bash play nicely
set -euo pipefail

git tag -a "$1" -m "Release $1" && git push --tags || git tag -d "$1"
./docker-make release
