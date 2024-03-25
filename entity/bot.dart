import 'dart:io';
import 'package:teledart/model.dart' hide File;
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../utils/decode_cli_message.dart';

const sayHi =
    'Вот и познакомились!\nТеперь при перезагрузке буду оповещать тебя!';

const rebootMessage =
    'Перезагружаюсь.\nВыйду на связь, как всё будет готово, а ты пока немного отдохни.';

const whichHostMessage = 'Какой хост хотите попинговать?';

List<BotCommand> commands = [
  BotCommand(command: 'start', description: 'Познакомиться'),
  BotCommand(command: 'reboot', description: 'Перезагрузить меня'),
  BotCommand(
      command: 'systeminfo', description: 'Показать информацию о системе'),
  BotCommand(command: 'uptime', description: 'Показать время работы'),
  BotCommand(command: 'ping', description: 'Попинговать хост'),
  BotCommand(command: 'ip', description: 'Узнать ip адрес хоста'),
];

class Bot {
  final String token;
  final String? chatId;
  late final TeleDart teleDart;

  Bot({required this.token, required this.chatId});

  Future<void> init() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(token, Event(username!));
    teleDart.start();
    if (chatId != null) {
      await teleDart.sendMessage(chatId, 'Я родился!');
    }
    teleDart
      ..setMyCommands(commands)
      ..onCommand('reboot').listen(reboot)
      ..onCommand('network_reset').listen(networkReset)
      ..onCommand('systeminfo').listen(systemInfo)
      ..onCommand('uptime').listen(uptime)
      ..onCommand('start').listen(start)
      ..onCommand('ip').listen(getIp)
      ..onCommand('ping').listen(ping);
  }

  Future<Message> sendLoadingMessage(TeleDartMessage msg) async {
    return await msg.reply('Думаю...');
  }

  Future<Message> answer(String text, Message msg) async {
    return await teleDart.editMessageText(text,
        chatId: chatId, messageId: msg.messageId);
  }

  Future<void> start(TeleDartMessage msg) async {
    try {
      ProcessResult result = await Process.run(
          'setx', ['TG_CHAT_ID', msg.chat.id.toString()],
          runInShell: true);
      await msg
          .reply('ChatID: ${msg.chat.id}\n${decodeCLIMessage(result)}\n$sayHi');
    } catch (e) {
      await msg.reply(e.toString());
    }
  }

  Future<void> reboot(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      await Process.run('shutdown', ['/r', '/t', '10']);
      await answer(rebootMessage, msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> ping(TeleDartMessage message) async {
    try {
      await message.reply(whichHostMessage);
      final sub = teleDart.onUrl().listen((_) {});
      sub.onData((data) async {
        var msg = await sendLoadingMessage(data);
        ProcessResult result =
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
          await Process.run('netsh', ['winsock', 'reset'], runInShell: true);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> systemInfo(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result = await Process.run('systeminfo', []);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }

  Future<void> uptime(TeleDartMessage message) async {
    try {
      var msg = await sendLoadingMessage(message);
      ProcessResult result = await Process.run(
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
          await Process.run('ipconfig', [], runInShell: true);
      await answer(decodeCLIMessage(result), msg);
    } catch (e) {
      await message.reply(e.toString());
    }
  }
}
