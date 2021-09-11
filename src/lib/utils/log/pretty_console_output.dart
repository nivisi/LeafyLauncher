import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class PrettyConsoleOutput extends ConsoleOutput {
  static final levelEmojis = {
    Level.verbose: '',
    Level.debug: '🐛 ',
    Level.info: '💡 ',
    Level.warning: '⚠️ ',
    Level.error: '⛔ ',
    Level.wtf: '👾 ',
  };

  @override
  void output(OutputEvent event) {
    for (var i = 0; i < event.lines.length; i++) {
      debugPrint('${i == 0 ? levelEmojis[event.level] : ''}${event.lines[i]}');
    }
  }
}
