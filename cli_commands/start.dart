import 'dart:io';

import '../entity/command/cli_command.dart';

class Start extends CliCommand {
  Start()
      : super(
          linCom: (arg) => Process.run('echo', ['~']),
          winCom: (arg) => Process.run('echo', ['%USERPROFILE%']),
        );
}
