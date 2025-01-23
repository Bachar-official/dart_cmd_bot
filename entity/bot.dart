import 'dart:async';

import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import 'command/command.dart';
import 'command_impl/command_impl.dart';
import 'locale.dart';
import 'settings_service.dart';

const engLang = 'English/Английский';
const ruLang = 'Русский/Russian';

class Bot {
  final String token;
  final SettingsService service;
  late final TeleDart teleDart;
  late List<Command> commands;
  final Map<String, StreamSubscription> _subscriptions = {};

  Bot(this.token, this.service);

  void init() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(token, Event(username!));
    teleDart.start();

    _initializeCommands();

    if (service.config.chatId != null) {
      await teleDart.sendMessage(
          service.config.chatId, service.config.locale.readyMessage);
    }

    _updateCommands();
  }

  void _initializeCommands() {
    commands = [
      StartCommand(teleDart, service),
      RebootCommand(teleDart, service.config),
      LocaleCommand(teleDart, service, this),
      PingCommand(teleDart, service.config),
      IpAddressCommand(teleDart, service.config),
    ];
  }

  void _clearSubscriptions() {
    for (var subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  void _updateCommands() async {
    _clearSubscriptions();
    await teleDart.deleteMyCommands();
    await teleDart
        .setMyCommands(commands.map((el) => el.toBotCommand()).toList());

    for (var command in commands) {
      _subscriptions[command.command] =
          teleDart.onCommand(command.command).listen(command.execute);
    }
  }

  Future<void> updateLocale(Locale locale) async {
    service.setLocale(locale);
    _initializeCommands();
    _updateCommands();

    if (service.config.chatId != null) {
      await teleDart.sendMessage(
          service.config.chatId, service.config.locale.localeChanged);
    }
  }

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
}
