import 'package:teledart/model.dart';

import '../entity/locale.dart';

Future<void> catchError(
    Locale locale, Object error, TeleDartMessage message) async {
  await message.reply('${locale.error} : ${error.toString()}');
}
