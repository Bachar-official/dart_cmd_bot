import 'dart:io';

import '../entity/command/cli_command.dart';

class IpAddress extends CliCommand {
  IpAddress()
      : super(
          linCom: (param) => Process.run('hostname', ['-I']),
          winCom: (param) => Process.run('ipconfig', []),
        );
}
