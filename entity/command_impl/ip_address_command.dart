import 'package:teledart/teledart.dart';

import '../../cli_commands/cli_commands.dart';
import '../../utils/catch_errors.dart';
import '../../utils/utils.dart';
import '../command/command.dart';
import '../config.dart';

class IpAddressCommand extends Command {
  final TeleDart telegram;
  final Config config;

  IpAddressCommand(this.telegram, this.config)
      : super(
          command: 'ip',
          description: config.locale.ip,
          locale: config.locale,
          teleDart: telegram,
          cmd: IpAddress(),
        );

  @override
  Future<void> execute(message) async {
    try {
      final answer =
          await TelegramUtils.sendLoadingMessage(msg: message, locale: locale);
      final result = await cmd!.run();
      await TelegramUtils.answer(
          text: decodeCLIMessage(result), msg: answer, teleDart: teleDart);
    } catch (e) {
      await catchError(locale, e, message);
    }
  }
}
