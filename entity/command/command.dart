import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

import '../locale.dart';
import 'cli_command.dart';

abstract class Command<T> {
  final String command;
  final String description;
  final Locale locale;
  final TeleDart teleDart;
  final CliCommand? cmd;

  const Command(
      {required this.command,
      required this.description,
      required this.locale,
      required this.teleDart,
      this.cmd});

  BotCommand toBotCommand();

  Future<T> execute(TeleDartMessage message);
}
