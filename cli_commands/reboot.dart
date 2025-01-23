import 'dart:io';

import '../entity/command/cli_command.dart';

class Reboot extends CliCommand {
  Reboot()
      : super(
          winCom: (arg) => Process.run('shutdown', ['/r', '/t', '10']),
          linCom: (arg) => Process.run('reboot', [], runInShell: true),
        );
}
