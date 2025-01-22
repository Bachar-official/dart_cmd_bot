import 'dart:io';

import 'config.dart';
import 'locale.dart';

class SettingsService {
  late Config config;
  static final configFile = File('./config.json');

  SettingsService() {
    config = Config.initial();
  }

  void _saveConfig() {
    configFile.writeAsStringSync(config.toJson());
  }

  void init() {
    if (!configFile.existsSync()) {
      configFile.createSync();
    } else {
      try {
        String content = configFile.readAsStringSync();
        config = Config.fromJson(content);
      } catch (e) {
        _saveConfig();
      }
    }
  }

  void setChatId(int chatId) {
    config = config.copyWith(chatId: chatId);
    _saveConfig();
  }

  void setLocale(Locale locale) {
    config = config.copyWith(locale: locale);
    _saveConfig();
  }
}
