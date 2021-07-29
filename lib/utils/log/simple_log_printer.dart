import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter({dynamic forObject}) : _prefix = forObject?.toString();

  final _formatted = DateFormat('HH:mm:ss');
  final String? _prefix;
  final prettyPrinter = PrettyPrinter(methodCount: 0);

  static final levelPrefixes = {
    Level.verbose: '[V]',
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
    Level.wtf: '[WTF]',
  };

  @override
  List<String> log(LogEvent event) {
    final messageStr = _stringifyMessage(event.message);
    final errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    final timeStr = _formatted.format(DateTime.now());
    final list = ['$timeStr ${_labelFor(event.level)} $messageStr$errorStr'];
    if (event.stackTrace == null) {
      return list;
    }
    final stackTrace = prettyPrinter.formatStackTrace(event.stackTrace, 0);
    if (stackTrace != null) {
      list.add(stackTrace);
    }
    return list;
  }

  String _labelFor(Level level) {
    return levelPrefixes[level]!;
  }

  String _stringifyMessage(dynamic message) {
    String msg;
    if (message is Map || message is Iterable) {
      const encoder = JsonEncoder.withIndent(null);
      msg = encoder.convert(message);
    } else {
      msg = message.toString();
    }
    if (_prefix == null) {
      return msg;
    }
    return '$_prefix : $msg';
  }
}
