#!/usr/bin/env bash

# make bash play nicely
set -euo pipefail

echo "Running the single lonely test"
./docker-make test

# use git tag -d <tag name> && git push --delete origin <tag name> to delete a remote tag if necessary
echo "Tagging the release"
git tag -a "$1" -m "Release $1" && git push --tags

echo "Starting the release build using docker-make"
./docker-make release
