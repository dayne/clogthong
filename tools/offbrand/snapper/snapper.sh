#!/usr/bin/bash

if ! command -v snapper > /dev/null; then
  echo "installing snapper for snapshots - for backup"
  sudo apt install -y snapper
fi

sudo snapper -c home create-config /home

sudo snapper -c home create --description "Snapshot of home directory"
