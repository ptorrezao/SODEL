#!/bin/bash

set -ex

IP=$(ifconfig eth0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
docker swarm init --advertise-addr $IP
#docker swarm join-token worker | grep token | awk '{ print $5 }'
