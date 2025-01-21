import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../cli_commands/reboot.dart';
import '../../utils/telegram_utils.dart';
import '../locale.dart';
import '../command/command.dart';

class RebootCommand extends Command<void> {
  final TeleDart telegram;
  final TeleDartMessage telegramMessage;
  RebootCommand(this.telegram, this.telegramMessage)
      : super(
            command: 'reboot',
            description: 'Rebooting',
            locale: EnLocale(),
            cmd: Reboot(),
            teleDart: telegram,
            message: telegramMessage);

  @override
  Future<void> execute() async {
    await TelegramUtils.sendLoadingMessage(
        msg: telegramMessage, locale: locale);
    await cmd?.run('');
  }

  @override
  BotCommand toBotCommand() =>
      BotCommand(command: command, description: description);
}
