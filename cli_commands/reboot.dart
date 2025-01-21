import 'dart:io';

import '../entity/command/cli_command.dart';

class Reboot extends CliCommand {
  Reboot()
      : super(
          linCom: (arg) => Process.run('shutdown', ['/r', '/t', '10']),
          winCom: (arg) => Process.run('reboot', [], runInShell: true),
        );
}
