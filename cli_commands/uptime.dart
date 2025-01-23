import 'dart:io';

import '../entity/command/cli_command.dart';

class Uptime extends CliCommand {
  Uptime()
      : super(
          linCom: (arg) => Process.run('uptime', ['-p']),
          winCom: (arg) => Process.run(
            'powershell',
            [
              '–Command',
              '(get-date) – (gcim Win32_OperatingSystem).LastBootUpTime'
            ],
          ),
        );
}
