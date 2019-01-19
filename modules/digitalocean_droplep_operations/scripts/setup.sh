#!/bin/bash

set -ex

echo "Installing dependencies"

for i in /tmp/scripts/*.install.sh
do
  chmod +x "$i" 
  sudo bash "$i"
done