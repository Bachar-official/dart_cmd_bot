import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'command/command.dart';
import 'command_impl/reboot_command.dart';
import 'command_impl/start_command.dart';
import 'settings_service.dart';

const engLang = 'English/Английский';
const ruLang = 'Русский/Russian';

class Bot {
  final String token;
  final SettingsService service;
  late final TeleDart teleDart;
  late List<Command> commands;

  Bot(this.token, this.service) {
    commands = [
      StartCommand(teleDart, service),
      RebootCommand(teleDart, service.config),
    ];
  }

  Future<void> init() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(token, Event(username!));
    teleDart.start();
    if (service.config.chatId != null) {
      await teleDart.sendMessage(
          service.config.chatId, service.config.locale.readyMessage);
    }
    teleDart.setMyCommands(commands.map((el) => el.toBotCommand()).toList());
    for (var command in commands) {
      teleDart.onCommand(command.command).listen(command.execute);
    }
    // ..onCommand('reboot').listen(reboot)
    // ..onCommand('network_reset').listen(networkReset)
    // ..onCommand('systeminfo').listen(systemInfo)
    // ..onCommand('uptime').listen(uptime)
    // ..onCommand('start').listen(start)
    // ..onCommand('ip').listen(getIp)
    // ..onCommand('ping').listen(ping);
  }

  // Future<Message> sendLoadingMessage(TeleDartMessage msg) async {
  //   return await msg.reply(locale.thinkingMessage);
  // }

  // Future<Message> answer(String text, Message msg) async {
  //   return await teleDart.editMessageText(text,
  //       chatId: msg.chat.id, messageId: msg.messageId);
  // }

  // Future<void> start(TeleDartMessage msg) async {
  //   try {
  //     await msg.reply(
  //         'ChatID: ${msg.chat.id}\n${locale.sayHi}');
  //   } catch (e) {
  //     await msg.reply(e.toString());
  //   }
  // }

  // Future<void> reboot(TeleDartMessage message) async {
  //   try {
  //     var msg = await sendLoadingMessage(message);
  //     if (Platform.isWindows) {
  //       await Process.run('shutdown', ['/r', '/t', '10']);
  //     } else if (Platform.isLinux) {
  //       await Process.run('reboot', [], runInShell: true);
  //     }
  //     await answer(locale.rebootMessage, msg);
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }

  // Future<void> ping(TeleDartMessage message) async {
  //   try {
  //     await message.reply(locale.whichHostMessage);
  //     final sub = teleDart.onUrl().listen((_) {});
  //     sub.onData((data) async {
  //       var msg = await sendLoadingMessage(data);
  //       ProcessResult result = Platform.isLinux ?
  //           await Process.run('ping', ['-c', '4', data.text ?? 'google.ru']) :
  //           await Process.run('ping', [data.text ?? 'google.ru']);
  //       await answer(decodeCLIMessage(result), msg);
  //       return;
  //     });
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }

  // Future<void> networkReset(TeleDartMessage message) async {
  //   try {
  //     var msg = await sendLoadingMessage(message);
  //     ProcessResult result =
  //         Platform.isLinux ? await Process.run('systemctl', ['restart', 'networking.service']) : await Process.run('netsh', ['winsock', 'reset'], runInShell: true);
  //     await answer(decodeCLIMessage(result), msg);
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }

  // Future<void> systemInfo(TeleDartMessage message) async {
  //   try {
  //     var msg = await sendLoadingMessage(message);
  //     ProcessResult result = Platform.isLinux ? await Process.run('uname', ['-a']) : await Process.run('systeminfo', []);
  //     await answer(decodeCLIMessage(result), msg);
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }

  // Future<void> uptime(TeleDartMessage message) async {
  //   try {
  //     var msg = await sendLoadingMessage(message);
  //     ProcessResult result = Platform.isLinux ? await Process.run('uptime', ['-p']) : await Process.run(
  //       'powershell',
  //       [
  //         '–Command',
  //         '(get-date) – (gcim Win32_OperatingSystem).LastBootUpTime'
  //       ],
  //     );
  //     await answer(decodeCLIMessage(result), msg);
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }

  // Future<void> getIp(TeleDartMessage message) async {
  //   try {
  //     var msg = await sendLoadingMessage(message);
  //     ProcessResult result =
  //         Platform.isLinux ? await Process.run('ifconfig', []) : await Process.run('ipconfig', [], runInShell: true);
  //     await answer(decodeCLIMessage(result), msg);
  //   } catch (e) {
  //     await message.reply(e.toString());
  //   }
  // }
}
