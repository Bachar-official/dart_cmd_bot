import 'package:teledart/teledart.dart';

import '../../cli_commands/cli_commands.dart';
import '../../utils/catch_errors.dart';
import '../../utils/utils.dart';
import '../command/ask_command.dart';
import '../command/command.dart';
import '../config.dart';

class PingCommand extends Command with AskCommand {
  final TeleDart telegram;
  final Config config;

  PingCommand(this.telegram, this.config)
      : super(
          command: 'ping',
          description: config.locale.ping,
          locale: config.locale,
          teleDart: telegram,
          cmd: Ping(),
        );

  @override
  Future<void> execute(message) async {
    try {
      final host = await ask(message, locale.whichHostMessage, SubSource.url);
      final waitingMessage =
          await TelegramUtils.sendLoadingMessage(msg: message, locale: locale);
      final result = await cmd!.run(host);
      await TelegramUtils.answer(
          text: decodeCLIMessage(result),
          msg: waitingMessage,
          teleDart: teleDart);
    } catch (e) {
      await catchError(locale, e, message);
    }
  }
}
