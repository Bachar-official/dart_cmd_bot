#!/bin/bash

read -p "Please enter your Telegram bot token: " BOT_TOKEN

LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/Bachar-official/dart_cmd_bot/releases/latest | grep "browser_download_url.*dart_cmd_bot_linux.exe" | cut -d '"' -f 4)
wget -O dart_cmd_bot_linux.exe "$LATEST_RELEASE_URL"
chmod +x dart_cmd_bot_linux.exe

SERVICE_FILE="/etc/systemd/system/cmd_bot.service"
cat <<EOF | sudo tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=CMD Telegram Bot
After=network.target

[Service]
ExecStart=$(pwd)/dart_cmd_bot_linux.exe
Restart=always
Environment="BOT_TOKEN=$BOT_TOKEN"
User=$USER
WorkingDirectory=$(pwd)

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable cmd_bot
sudo systemctl start cmd_bot

echo "Installation complete. Please launch /start command in your Telegram bot."