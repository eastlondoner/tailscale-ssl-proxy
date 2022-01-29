#!/usr/bin/env sh

# make sh play nicely
set -euo pipefail

git tag -a "$1" -m "Release $1" && git push --tags
docker build --target release -t tailscale-ssl-proxy_build-release .
docker compose --env-file .auth/github.env -f docker-compose.build.yml up
docker compose -f docker-compose.build.yml down
