import 'dart:io';

String getConfigFile() {
  final fileName = 'cmd_bot.conf';
  final envVars = Platform.environment;
  if (Platform.isWindows) {
    return '${envVars['UserProfile']!}/$fileName';
  } else if (Platform.isLinux || Platform.isMacOS) {
    return '${envVars['HOME']!}/$fileName';
  } else {
    throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
  }
}

String? getChatId() {
  final file = File(getConfigFile());
  if (!file.existsSync()) {
    return null;
  }
  return file.readAsStringSync();
}
