#!/usr/bin/env bash
# Run the multiplayer server transport tests in a PHP 8.2.35 container.
#
# Builds a small cached image (php:8.2.35-cli + sockets extension) the first time,
# then reuses it so subsequent runs are fast. Pass a specific test file to run
# just that one, e.g.:  tests/run.sh tests/WebSocketTest.php
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
image="pr2-php-test:8.2.35"
target="${1:-tests/run.php}"

# build the test image only if it is missing
if ! docker image inspect "$image" >/dev/null 2>&1; then
    echo "Building $image (php:8.2.35-cli + sockets)..."
    docker build -t "$image" - <<'DOCKERFILE'
FROM php:8.2.35-cli
RUN docker-php-ext-install sockets
DOCKERFILE
fi

exec docker run --rm -v "$repo_root":/app -w /app "$image" php "$target"
