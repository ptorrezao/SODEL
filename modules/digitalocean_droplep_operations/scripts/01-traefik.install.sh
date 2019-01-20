#!/bin/bash

set -ex

ENV_FILE="/tmp/scripts/docker-compose/.env"
for i in $(cat "$ENV_FILE") ; do export  $i; done

COMPOSE_FILE="docker-compose.traefik.yml"

docker stack deploy -c "/tmp/scripts/docker-compose/$COMPOSE_FILE" traefik
