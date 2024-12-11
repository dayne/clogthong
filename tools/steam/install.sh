#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to install Steam
install_steam() {
    echo "Steam not found. Installing..."

    # Update package list
    sudo apt update

    # Install dependencies
    sudo apt install -y wget gdebi-core

    # Download the latest Steam .deb package
    STEAM_DEB_URL="https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
    TEMP_DEB="/tmp/steam_latest.deb"
    wget -O "$TEMP_DEB" "$STEAM_DEB_URL"

    # Install the .deb package
    sudo gdebi -n "$TEMP_DEB"

    # Clean up
    rm -f "$TEMP_DEB"

    echo "Steam installation completed."
}

# Main script
if command_exists steam; then
    echo "Steam is already installed."
else
    install_steam
fi
