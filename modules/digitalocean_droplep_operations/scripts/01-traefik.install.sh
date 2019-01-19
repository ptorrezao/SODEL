#!/bin/bash

set -ex

ENV_FILE="/tmp/scripts/docker-compose/.env"
for i in $(cat "$ENV_FILE") ; do export  $i; done

NET_ID=$(docker network create -d overlay traefik_net)
COMPOSE_FILE="docker-compose.traefik.yml"
if  [[ ! -z "$NET_ID " ]]
then
   docker stack deploy -c "/tmp/scripts/docker-compose/$COMPOSE_FILE" traefik
else
  echo "FAILURE - $COMPOSE_FILE not applied"
  exit 1
fi