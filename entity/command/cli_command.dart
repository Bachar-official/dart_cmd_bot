import 'dart:io';

abstract class CliCommand {
  final Future<ProcessResult> Function(String) winCom;
  final Future<ProcessResult> Function(String) linCom;

  const CliCommand({required this.linCom, required this.winCom});

  Future<ProcessResult> run(String arg) {
    switch (Platform.operatingSystem) {
      case 'windows':
        return winCom(arg);
      case 'linux':
        return linCom(arg);
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }
}
