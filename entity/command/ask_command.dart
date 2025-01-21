import 'dart:async';

import 'package:teledart/model.dart';

import 'command.dart';

enum SubSource { message, url }

mixin AskCommand on Command {
  Future<String> ask(String question, SubSource source) async {
    await super.message.reply(question);
    final completer = Completer<String>();
    final sub = _getSubscription(source);
    sub.onData((data) => completer.complete(data.text ?? ''));
    final result = await completer.future;
    await sub.cancel();
    return result;
  }

  Future<String> askInline(String question, ReplyMarkup markup) async {
    await message.reply(question, replyMarkup: markup);
    final completer = Completer<String>();
    final sub = super.teleDart.onCallbackQuery().listen((_) {});
    sub.onData((data) => completer.complete(data.data ?? ''));
    final result = await completer.future;
    await sub.cancel();
    return result;
  }

  StreamSubscription<TeleDartMessage> _getSubscription(SubSource source) {
    switch (source) {
      case SubSource.url:
        return super.teleDart.onUrl().listen((_) {});
      case SubSource.message:
      default:
        return super.teleDart.onMessage().listen((_) {});
    }
  }
}
