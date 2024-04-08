# CMD_BOT

Telegram bot for remote maintenance of a work computer.

## Motivation

There are situations when your remote work computer won't response via RDP after a connection to another network. So, you could reset network or reboot it, but definitely can't do it.
This software may solve this problem (I hope 😊).

## Requirements

- Telegram bot token;
- Local user account (for Windows).

## Installing

- Install [Dart SDK](https://dart.dev/get-dart#install)
- Clone this repository
- Run `dart compile exe bin/main.exe` at root project directory.

### Linux

- Move compiled `main.exe` at desired directory.
- Fill service file template:

```
[Unit]
Description=Telegram service bot
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=<your executable>
WorkingDirectory=<your working directory>
Environment=BOT_TOKEN=<your TG token>

[Install]
WantedBy=multi-user.target
```

- Move service file to `/lib/systemd/system/`
- Run `sudo systemctl daemon-reload`
- Run `sudo systemctl <your-service-name>.service`

### Windows

Under construction
