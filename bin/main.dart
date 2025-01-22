import 'dart:io';
import 'package:win32/win32.dart';

import '../entity/bot.dart';
import '../entity/settings_service.dart';

void main(List<String> arguments) async {
  if (Platform.isWindows) {
    ShowWindow(GetConsoleWindow(), SHOW_WINDOW_CMD.SW_HIDE);
  }
  String? token = Platform.environment['BOT_TOKEN'];
  if (token == null) {
    throw Exception('Token is empty!');
  }
  final service = SettingsService()..init();
  
  Bot bot =
      Bot(token, service);
  await bot.init();
}
