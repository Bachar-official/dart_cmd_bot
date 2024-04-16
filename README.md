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

- Move compiled `main.exe` at desired directory.
- Set environment variable `BOT_TOKEN` with your TG token.
- Open Task Scheduler (`taskschd.msc`).
- Create a new task.

#### Task parameters

- Start at boot and repeat after 5 minutes;
- Unlimited number of restart attempts;
- Don't stop the task.

## Commands

- `/start` Knowing. The bot will write you a chat ID, which you will need to enter into the TG_CHAT_ID environment variable.
- `/reboot` Reboot your machine. The bot will write you 'Ready' when rebooting is completed.
- `/systeminfo` Information about your system.
- `/uptime` Write current machine uptime.
- `/ping` Ping desired host.
- `/ip` Write machine IP address.
