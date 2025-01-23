import 'package:teledart/teledart.dart';

import '../../cli_commands/cli_commands.dart';
import '../../utils/catch_errors.dart';
import '../../utils/utils.dart';
import '../command/command.dart';
import '../config.dart';

class UptimeCommand extends Command {
  final TeleDart telegram;
  final Config config;

  UptimeCommand(this.telegram, this.config)
      : super(
          command: 'uptime',
          description: config.locale.uptime,
          locale: config.locale,
          teleDart: telegram,
          cmd: Uptime(),
        );

  @override
  Future<void> execute(message) async {
    try {
      final waitMessage =
          await TelegramUtils.sendLoadingMessage(msg: message, locale: locale);
      final result = await cmd!.run();
      await TelegramUtils.answer(
          text: decodeCLIMessage(result), msg: waitMessage, teleDart: teleDart);
    } catch (e) {
      await catchError(locale, e, message);
    }
  }
}
