import 'dart:io';
import 'package:teledart/model.dart' hide File;
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../const/locale.dart';
import '../utils/decode_cli_message.dart';
import 'locale.dart';

const engLang = 'English/Английский';
const ruLang = 'Русский/Russian';

class Bot {
  final String token;
  final String? chatId;
  final Locale locale;
  late final TeleDart teleDart;

  Bot({required this.token, required this.chatId, required this.locale});

  Future<void> init() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(token, Event(username!));
    teleDart.start();
    if (chatId != null) {
      await teleDart.sendMessage(chatId, locale.readyMessage);
    }
    teleDart
      ..setMyCommands(getCommands(locale))
      ..onCommand('reboot').listen(reboot)
      ..onCommand('network_reset').listen(networkReset)
      ..onCommand('systeminfo').listen(systemInfo)
      ..onCommand('uptime').listen(uptime)
      ..onCommand('start').listen(start)
      ..onCommand('ip').listen(getIp)
      ..onCommand('locale').listen(setLocale)
      ..onCommand('ping').listen(ping);
  }

  Future<Message> sendLoadingMessage(TeleDartMessage msg) async {
    return await msg.reply(locale.thinkingMessage);
  }

  Future<Message> answer(String text, Message msg) async {
    return await teleDart.editMessageText(text,
        chatId: chatId, messageId: msg.messageId);
  }

  Future<void> start(TeleDartMessage msg) async {
    try {
      ProcessResult result = Platform.isLinux ? await Process.run('export', ['TG_CHAT_ID', 'msg.chat.id.toString()']) : await Process.run(
          'setx', ['TG_CHAT_ID', msg.chat.id.toString()],
          runInShell: true);
      await msg.reply(
          'ChatID: ${msg.chat.id}\n${decodeCLIMessage(result)}\n${locale.readyMessage}');
    } catch (e) {
      await msg.reply(e.toString());
    }
  }

  Future<void> setLocale(TeleDartMessage msg) async {
    var ruButton = InlineKeyboardButton(text: ruLang);
    var enButton = InlineKeyboardButton(text: engLang);
    final markup = InlineKeyboardMarkup(inlineKeyboard: [
      [ruButton, enButton]
    ]);
    try {
      await msg.reply('Выберите язык', replyMarkup: markup);
      final sub = teleDart.onMessage().listen((_) {});
      sub.onData((data) async {
        var langMessage = await sendLoadingMessage(data);
        if (Platform.isLinux) {
          await Process.run('export', ['TG_LOCALE', data.text == ruLang ? 'ru' : 'en']);
        }
        await Process.run(
          'setx',
          ['TG_LOCALE', data.text == ruLang ? 'ru' : 'en'],
        );
        await answer(locale.localeChanged, langMessage);
      });
    } catch (e) {
      await msg.reply(e.toString());
    }
  }

  Future<void> reboot(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      if (Platform.isWindows) {
        await Process.run('shutdown', ['/r', '/t', '10']);
      } else if (Platform.isLinux) {
        await Process.run('reboot', []);
      }      
      await answer(locale.rebootMessage, msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> ping(TeleDartMessage message) async {
    try {
      await message.reply(locale.whichHostMessage);
      final sub = teleDart.onUrl().listen((_) {});
      sub.onData((data) async {
        var msg = await sendLoadingMessage(data);
        ProcessResult result = Platform.isLinux ?
            await Process.run('ping', ['-c', '4', data.text ?? 'google.ru']) :
            await Process.run('ping', [data.text ?? 'google.ru']);
        await answer(decodeCLIMessage(result), msg);
        return;
      });
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> networkReset(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result =
          Platform.isLinux ? await Process.run('systemctl', ['restart', 'networking.service']) : await Process.run('netsh', ['winsock', 'reset'], runInShell: true);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> systemInfo(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result = Platform.isLinux ? await Process.run('uname', ['-a']) : await Process.run('systeminfo', []);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> uptime(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result = Platform.isLinux ? await Process.run('uptime', ['-p']) : await Process.run(
        'powershell',
        [
          '–Command',
          '(get-date) – (gcim Win32_OperatingSystem).LastBootUpTime'
        ],
      );
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> getIp(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result =
          Platform.isLinux ? await Process.run('ifconfig', []) : await Process.run('ipconfig', [], runInShell: true);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }
}
