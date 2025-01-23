import 'package:teledart/model.dart' hide File;
import 'package:teledart/teledart.dart';

import '../command/ask_command.dart';
import '../command/command.dart';
import '../settings_service.dart';

class StartCommand extends Command with AskCommand {
  final TeleDart telegram;
  final SettingsService service;
  StartCommand(this.telegram, this.service)
      : super(
          command: 'start',
          description: service.config.locale.knowing,
          locale: service.config.locale,
          teleDart: telegram,
          cmd: null,
        );

  @override
  Future<void> execute(message) async {
    try {
      final chatId = service.config.chatId;
      final messageChaId = message.chat.id;
      if (chatId != null) {
        final keyboard = InlineKeyboardMarkup(
          inlineKeyboard: [
            [
              InlineKeyboardButton(text: locale.update, callbackData: 'update'),
              InlineKeyboardButton(
                  text: locale.notUpdate, callbackData: 'cancel'),
            ]
          ],
        );
        final answer =
            await askInline(message, locale.configExisting, keyboard);
        if (answer == 'update') {
          service.setChatId(messageChaId);
          await message.reply('Chat ID updated.');
        } else {
          await message.reply('OK.');
        }
      } else {
        service.setChatId(messageChaId);
        await message.reply(locale.willNotify);
      }
    } catch (e) {
      await message.reply(e.toString());
    }
  }
}
