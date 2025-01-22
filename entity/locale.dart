abstract class Locale {
  final String knowing;
  final String reboot;
  final String systeminfo;
  final String uptime;
  final String ping;
  final String ip;
  final String sayHi;
  final String rebootMessage;
  final String whichHostMessage;
  final String readyMessage;
  final String thinkingMessage;
  final String configExisting;
  final String update;
  final String notUpdate;
  final String willNotify;

  const Locale({
    required this.knowing,
    required this.reboot,
    required this.systeminfo,
    required this.uptime,
    required this.ping,
    required this.ip,
    required this.sayHi,
    required this.rebootMessage,
    required this.whichHostMessage,
    required this.readyMessage,
    required this.thinkingMessage,
    required this.configExisting,
    required this.notUpdate,
    required this.update,
    required this.willNotify,
  });
}

class EnLocale extends Locale {
  const EnLocale()
      : super(
          knowing: 'Knowing',
          reboot: 'Reboot me',
          systeminfo: 'Show system info',
          uptime: 'Show uptime',
          ping: 'Ping a host',
          ip: 'Get ip address',
          sayHi: 'Please specify a TG_CHAT_ID environment variable written above and reboot your system.',
          rebootMessage:
              'Rebooting.\nTake a little break, I\'ll be online soon.',
          whichHostMessage: 'Which host do you want to ping?',
          readyMessage: 'Ready',
          thinkingMessage: 'Thinking...',
          configExisting:
              'Existing config file detected. Do you want to update it?',
          update: 'Update',
          notUpdate: 'Don\'t update',
          willNotify: 'Nice to meet you!\n'
              'Now when I reboot, I\'ll let you know when I\'m ready!',
        );
}

class RuLocale extends Locale {
  const RuLocale()
      : super(
          knowing: 'Познакомиться',
          reboot: 'Перезагрузить меня',
          systeminfo: 'Показать информацию о системе',
          uptime: 'Показать время работы',
          ping: 'Попинговать хост',
          ip: 'Узнать мой ip адрес',
          sayHi: 'Пожалуйста, установите в переменную окружения TG_CHAT_ID число, указанное выше и перезагрузите компьютер.',
          rebootMessage:
              'Перезагружаюсь...\nВайду на связь, как всё будет готово, а ты пока немного отдохни.',
          whichHostMessage: 'Какой хост хотите попинговать?',
          readyMessage: 'Я родился!',
          thinkingMessage: 'Думаю...',
          configExisting:
              'Найден существующий файл конфигурации. Хотите ли его обновить?',
          update: 'Обновить',
          notUpdate: 'Не обновлять',
          willNotify: 'Приятно познакомиться!\n'
              'Теперь при перезагрузке буду уведомлять вас!',
        );
}

Locale chooseLocale(String? locale) {
  if (locale == null || locale == 'en') {
    return EnLocale();
  }
  return RuLocale();
}
