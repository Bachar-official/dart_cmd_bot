import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../cli_commands/reboot.dart';
import '../../utils/catch_errors.dart';
import '../../utils/telegram_utils.dart';
import '../config.dart';
import '../command/command.dart';

class RebootCommand extends Command {
  final TeleDart telegram;
  final Config config;
  RebootCommand(this.telegram, this.config)
      : super(
          command: 'reboot',
          description: config.locale.reboot,
          locale: config.locale,
          cmd: Reboot(),
          teleDart: telegram,
        );

  @override
  Future<void> execute(TeleDartMessage message) async {
    try {
      await TelegramUtils.sendLoadingMessage(msg: message, locale: locale);
      await cmd!.run();
    } catch (e) {
      await catchError(locale, e, message);
    }
  }
}
