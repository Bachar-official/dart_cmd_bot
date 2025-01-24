#!/bin/bash

SERVICE_NAME="cmd_bot"
if systemctl is-active --quiet $SERVICE_NAME; then
    echo "Stopping service..."
    sudo systemctl stop $SERVICE_NAME
fi

if systemctl is-enabled --quiet $SERVICE_NAME; then
    echo "Disabling service..."
    sudo systemctl disable $SERVICE_NAME
fi

if [ -f "/etc/systemd/system/$SERVICE_NAME.service" ]; then
    echo "Removing service file..."
    sudo rm /etc/systemd/system/$SERVICE_NAME.service
    sudo systemctl daemon-reload
fi

echo "Removing binaries..."
sudo rm $(pwd)/dart_cmd_bot_linux.exe

echo "Removing configs..."
sudo rm $(pwd)/config.json

echo "Uninstalling complete."
