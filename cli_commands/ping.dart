import 'dart:io';

import '../entity/command/cli_command.dart';

class Ping extends CliCommand {
  Ping()
      : super(
          winCom: (path) => Process.run(
              'ping', ['-c', '4', path.isEmpty ? 'google.ru' : path]),
          linCom: (path) =>
              Process.run('ping', [path.isEmpty ? 'google.ru' : path]),
        );
}
