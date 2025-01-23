import 'package:teledart/model.dart';

import '../entity/locale.dart';



List<BotCommand> getCommands(Locale locale) => [
      BotCommand(command: 'start', description: locale.knowing),
      BotCommand(command: 'reboot', description: locale.reboot),
      BotCommand(command: 'systeminfo', description: locale.systeminfo),
      BotCommand(command: 'uptime', description: locale.uptime),
      BotCommand(command: 'ping', description: locale.ping),
      BotCommand(command: 'ip', description: locale.ip),
    ];
