#!/usr/bin/bash


if command -v rclone > /dev/null; then
  echo "Skipping install of rclone -- already installed"
else
  echo "Missing rclone ... installing"
  sudo apt install rclone
fi
