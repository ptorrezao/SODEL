#!/bin/bash

set -ex

COMPOSE_PATH="/tmp/scripts/docker-compose"
ENV_FILE="/tmp/scripts/docker-compose/.env"
for i in $(cat "$ENV_FILE") ; do export  $i; done

COMPOSE_FILE_BASE="$COMPOSE_PATH/docker-compose.jenkins.yml"
COMPOSE_FILE_EXTEND="$COMPOSE_PATH/docker-compose.jenkins.traefik.yml"

docker stack deploy \
  -c "$COMPOSE_FILE_BASE" \
  -c "$COMPOSE_FILE_EXTEND" \
  jenkins