#!/bin/bash

set -e

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

# Define variables
BINARY_URL="https://github.com/madroots/cameraleech/raw/master/compiled/cameraleech"
CONFIG_URL="https://github.com/madroots/cameraleech/raw/master/compiled/cameraleech.toml"
SERVICE_URL="https://github.com/madroots/cameraleech/raw/master/compiled/cameraleech.service"

# Define installation paths
BINARY_PATH="/usr/local/bin/"
CONFIG_PATH="/etc/cameraleech.toml"
SERVICE_PATH="/etc/systemd/system/cameraleech.service"

# Download binary, config, and service file
echo "Downloading binary..."
curl -fsSL $BINARY_URL -o /tmp/cameraleech_binary
echo "Downloading config..."
curl -fsSL $CONFIG_URL -o /tmp/cameraleech_config.toml
echo "Downloading service file..."
curl -fsSL $SERVICE_URL -o /tmp/cameraleech_service.service

# Install binary
echo "Installing binary..."
sudo cp /tmp/cameraleech_binary $BINARY_PATH

# Install config
echo "Installing config..."
sudo cp /tmp/cameraleech_config.toml $CONFIG_PATH

# Install service file
echo "Installing service file..."
sudo cp /tmp/cameraleech_service.service $SERVICE_PATH

# Enable the service
echo "Enabling service..."
sudo systemctl enable cameraleech.service

# Clean up temporary files
echo "Cleaning up..."
rm /tmp/cameraleech_binary
rm /tmp/cameraleech_config.toml
rm /tmp/cameraleech_service.service

echo "Installation completed. You should now configure cameraleech by editing $CONFIG_PATH and $SERVICE_PATH"
