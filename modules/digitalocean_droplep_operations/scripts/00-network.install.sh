#!/bin/bash

set -ex

ENV_FILE="/tmp/scripts/docker-compose/.env"
for i in $(cat "$ENV_FILE") ; do export  $i; done

NET_ID=$(docker network create -d overlay traefik_net)
if  [[ -z "$NET_ID " ]]
then
  echo "FAILURE - $COMPOSE_FILE not applied"
  exit 1
fi