import 'dart:io';
import 'package:win32/win32.dart';

import '../const/locale.dart';
import '../entity/bot.dart';

void main(List<String> arguments) async {
  if (Platform.isWindows) {
    ShowWindow(GetConsoleWindow(), SW_HIDE);
  }
  Map<String, String> env = Platform.environment;
  String? token = env['BOT_TOKEN'];
  String? chatId = env['TG_CHAT_ID'];
  if (token == null) {
    throw Exception('Token is empty!');
  }
  Bot bot =
      Bot(token: token, chatId: chatId, locale: chooseLocale(env['TG_LOCALE']));
  await bot.init();
}
