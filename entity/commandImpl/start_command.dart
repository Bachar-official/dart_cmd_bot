import 'dart:io';

import 'package:teledart/model.dart' hide File;
import 'package:teledart/teledart.dart';

import '../../cli_commands/start.dart';
import '../../utils/decode_cli_message.dart';
import '../../utils/get_config_file.dart';
import '../locale.dart';
import '../command/ask_command.dart';
import '../command/command.dart';

class StartCommand extends Command<void> with AskCommand {
  final TeleDart telegram;
  final TeleDartMessage telegramMessage;
  final Future<ProcessResult> runCommand;
  StartCommand(this.telegram, this.telegramMessage, this.runCommand)
      : super(
          command: 'start',
          description: 'Knowing',
          locale: EnLocale(),
          teleDart: telegram,
          message: telegramMessage,
          cmd: Start(),
        );

  @override
  Future<void> execute() async {
    try {
      final configFile = File(getConfigFile());
      if (await configFile.exists()) {
        final keyboard = InlineKeyboardMarkup(
          inlineKeyboard: [
            [
              InlineKeyboardButton(text: 'Update', callbackData: 'update'),
              InlineKeyboardButton(
                  text: 'Don\'t update', callbackData: 'cancel'),
            ]
          ],
        );
        final answer = await askInline(
            'Existing config file detected. Do you want to update it?',
            keyboard);
        if (answer == 'update') {
          configFile.writeAsStringSync('${message.chat.id}');
          await message.reply('Chat ID updated.');
        } else {
          await message.reply('OK.');
        }
      } else {
        configFile.writeAsStringSync('${message.chat.id}');
        await message.reply('Nice to meet you!\n'
            'Now when I reboot, I\'ll let you know when I\'m ready!');
      }
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  @override
  BotCommand toBotCommand() =>
      BotCommand(command: command, description: description);
}
