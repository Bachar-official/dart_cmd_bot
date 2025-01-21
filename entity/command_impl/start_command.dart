import 'dart:io';

import 'package:teledart/model.dart' hide File;
import 'package:teledart/teledart.dart';

import '../../cli_commands/start.dart';
import '../../utils/utils.dart';
import '../locale.dart';
import '../command/ask_command.dart';
import '../command/command.dart';

class StartCommand extends Command<void> with AskCommand {
  final TeleDart telegram;
  StartCommand(this.telegram)
      : super(
          command: 'start',
          description: 'Knowing',
          locale: EnLocale(),
          teleDart: telegram,
          cmd: Start(),
        );

  @override
  Future<void> execute(message) async {
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
            message,
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
