import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../cli_commands/reboot.dart';
import '../../utils/telegram_utils.dart';
import '../locale.dart';
import '../command/command.dart';

class RebootCommand extends Command<void> {
  final TeleDart telegram;
  RebootCommand(this.telegram)
      : super(
          command: 'reboot',
          description: 'Rebooting',
          locale: EnLocale(),
          cmd: Reboot(),
          teleDart: telegram,
        );

  @override
  Future<void> execute(TeleDartMessage message) async {
    await TelegramUtils.sendLoadingMessage(msg: message, locale: locale);
    await cmd?.run('');
  }

  @override
  BotCommand toBotCommand() =>
      BotCommand(command: command, description: description);
}
