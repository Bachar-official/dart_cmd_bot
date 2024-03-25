import 'package:teledart/model.dart';

Map<String, String> localeEn = {
  'knowing': 'Knowing',
  'reboot': 'Reboot me',
  'systeminfo': 'Show system info',
  'uptime': 'Show uptime',
  'ping': 'Ping a host',
  'ip': 'Get ip address',
  'sayHi': 'Nice to meet you!\nNow when will I be online, I will notify you!',
  'rebootMessage': 'Rebboting.\nTake a little break, I\'ll be online soon.',
  'whichHostMessage': 'Which host do you want to ping?',
  'readyMessage': 'Ready',
  'thinkingMessage': 'Thinking...',
  'locale': 'Choose a language',
  'localeChanged': 'Locale changed. Reboot needed.',
};

Map<String, String> localeRu = {
  'knowing': 'Познакомиться',
  'reboot': 'Перезагрузить меня',
  'systeminfo': 'Показать информацию о системе',
  'uptime': 'Показать время работы',
  'ping': 'Попинговать хост',
  'ip': 'Узнать мой ip адрес',
  'sayHi': 'Привет!\nТеперь при перезагрузке буду оповещать тебя!',
  'rebootMessage':
      'Перезагружаюсь...\nВыйду на связь, как всё будет готово, а ты пока немного отдохни.',
  'whichHostMessage': 'Какой хост хотите попинговать?',
  'readyMessage': 'Я родился!',
  'thinkingMessage': 'Думаю...',
  'locale': 'Выбрать язык',
  'localeChanged': 'Язык изменён. Требуется перезагрузка.',
};

Map<String, String> chooseLocale(String? locale) {
  if (locale == null || locale == 'en') {
    return localeEn;
  }
  return localeRu;
}

List<BotCommand> getCommands(Map<String, String> locale) => [
      BotCommand(command: 'start', description: locale['knowing']!),
      BotCommand(command: 'reboot', description: locale['reboot']!),
      BotCommand(command: 'systeminfo', description: locale['systeminfo']!),
      BotCommand(command: 'uptime', description: locale['uptime']!),
      BotCommand(command: 'ping', description: locale['ping']!),
      BotCommand(command: 'ip', description: locale['ip']!),
      BotCommand(command: 'locale', description: locale['locale']!),
    ];
