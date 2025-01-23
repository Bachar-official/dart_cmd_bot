import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../../utils/catch_errors.dart';
import '../bot.dart';
import '../command/ask_command.dart';
import '../command/command.dart';
import '../locale.dart';
import '../settings_service.dart';

class LocaleCommand extends Command with AskCommand {
  final TeleDart telegram;
  final SettingsService service;
  final Bot bot;
  LocaleCommand(this.telegram, this.service, this.bot)
      : super(
          command: 'locale',
          description: service.config.locale.chooseLocale,
          locale: service.config.locale,
          teleDart: telegram,
          cmd: null,
        );

  @override
  Future<void> execute(message) async {
    try {
      final keyboard = InlineKeyboardMarkup(
        inlineKeyboard: [
          [
            InlineKeyboardButton(text: 'English', callbackData: 'eng'),
            InlineKeyboardButton(text: 'Русский', callbackData: 'rus'),
          ]
        ],
      );
      final answer = await askInline(message, locale.chooseLocale, keyboard);
      final newLocale = answer == 'eng' ? EnLocale() : RuLocale();
      await bot.updateLocale(newLocale);
    } catch (e) {
      await catchError(locale, e, message);
    }
  }
}
