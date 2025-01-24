# CMD_BOT

Telegram bot for remote maintenance of a work computer.

# Motivation

There are situations when your remote work computer won't response via RDP after a connection to another network. So, you could reset network or reboot it, but definitely can't do it.
This software may solve this problem (I hope 😊).

# Requirements

- Telegram bot token;
- Local user account (for Windows).

# Build from sources

- Install [Dart SDK](https://dart.dev/get-dart#install)
- Clone this repository
- Run `dart pub get` for installing dependencies
- Run `dart compile exe bin/main.exe` at root project directory.

# Installation

## Linux

### systemd-based distros

Just launch `install.sh` script at root repo directory.

## Windows

Just launch `install.ps1` script at root repo directory.

# Uninstallation

## Linux

### systemd-based- distros

Just launch `uninstall.sh` script at root repo directory.

## Windows

Just launch `uninstall.ps1` script at root repo directory.

## Commands

- `/start` Knowing. Bot will save your chat ID.
- `/reboot` Reboot your machine. The bot will write you 'Ready' when rebooting is completed (if /start command already used and binary file is launch when computer is on).
- `/locale` Change bot language (English/Russian).
- `/uptime` Write current machine uptime.
- `/ping` Ping desired host.
- `/ip` Write machine IP address.
