#!/bin/bash
# Build and run the MCP Unity Node.js server Docker image
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOCKER_IMAGE="mcp-unity-server"
SERVER_DIR="$SCRIPT_DIR/Server~"

docker build -t "$DOCKER_IMAGE" "$SERVER_DIR"
# Stop any existing container with the same name
if docker ps -a --format '{{.Names}}' | grep -q "^$DOCKER_IMAGE\$"; then
  docker stop "$DOCKER_IMAGE" >/dev/null 2>&1 || true
  docker rm "$DOCKER_IMAGE" >/dev/null 2>&1 || true
fi
# Run the container detached
docker run -d --rm --name "$DOCKER_IMAGE" -p 8090:8090 "$DOCKER_IMAGE"
