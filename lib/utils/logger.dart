import 'dart:developer';

import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrefixPrinter(
    PrettyPrinter(
      errorMethodCount: null,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTime,
    ),
  ),
  output: DeveloperConsoleOutput(),
);

class DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}
