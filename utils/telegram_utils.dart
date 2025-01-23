import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../entity/locale.dart';

abstract class TelegramUtils {
  static Future<Message> sendLoadingMessage(
      {required TeleDartMessage msg, required Locale locale}) async {
    return await msg.reply(locale.thinkingMessage);
  }

  static Future<Message> answer(
      {required String text,
      required Message msg,
      required TeleDart teleDart}) async {
    return await teleDart.editMessageText(text,
        chatId: msg.chat.id, messageId: msg.messageId);
  }
}
