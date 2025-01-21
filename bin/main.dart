import 'dart:io';
import 'package:win32/win32.dart';

import '../const/locale.dart';
import '../entity/bot.dart';
import '../utils/utils.dart';

void main(List<String> arguments) async {
  if (Platform.isWindows) {
    ShowWindow(GetConsoleWindow(), SHOW_WINDOW_CMD.SW_HIDE);
  }
  Map<String, String> env = Platform.environment;
  String? token = env['BOT_TOKEN'];
  String? chatId = getChatId();
  if (token == null) {
    throw Exception('Token is empty!');
  }
  Bot bot =
      Bot(token: token, chatId: chatId, locale: chooseLocale(env['TG_LOCALE']));
  await bot.init();
}
