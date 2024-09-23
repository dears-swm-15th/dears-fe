import 'dart:developer';

import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: CustomLogPrinter(),
  output: DeveloperConsoleOutput(),
);

class CustomLogPrinter extends LogPrinter {
  static const levelPrefixes = {
    Level.trace: "TRACE",
    Level.debug: "DEBUG",
    Level.info: "INFO",
    Level.warning: "WARN",
    Level.error: "ERROR",
    Level.fatal: "FATAL",
  };

  static AnsiColor getLevelColor(Level level) {
    return PrettyPrinter.defaultLevelColors[level] ?? const AnsiColor.none();
  }

  @override
  List<String> log(LogEvent event) {
    final time = DateTimeFormat.onlyTime(event.time);

    final color = getLevelColor(event.level);
    final label = (levelPrefixes[event.level] ?? "").padLeft(5);

    final error = event.error;
    final stackTrace = event.stackTrace ?? StackTrace.current;

    return [
      "$time ${color(label)} ${event.message}",
      if (error != null) ...[
        "Error: $error",
        "$stackTrace",
      ],
    ];
  }
}

class DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}
