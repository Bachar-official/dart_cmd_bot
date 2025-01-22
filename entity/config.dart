import 'dart:convert';

import 'locale.dart';

class Config {
  final int? chatId;
  final Locale locale;

  const Config({required this.chatId, required this.locale});

  Config.initial()
      : chatId = null,
        locale = EnLocale();

  factory Config.fromJson(String str) {
    final map = jsonDecode(str);
    return Config(chatId: map['chatId'], locale: chooseLocale(map['locale']));
  }

  Config copyWith({
    int? chatId,
    Locale? locale,
    bool nullableChatId = false,
  }) =>
      Config(
        chatId: nullableChatId ? chatId : chatId ?? this.chatId,
        locale: locale ?? this.locale,
      );

  String toJson() => jsonEncode({'chatId': chatId, 'locale': locale});
}
