import 'dart:async';
import 'dart:io';

import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/utils/log/file_logger.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

class FileOutput extends LogOutput {
  final _fileLogService = injector<FileLogger>();

  final _lock = Lock();

  Future<void> write(OutputEvent event) {
    final file = _fileLogService.getFileForToday();
    return file.writeAsString(
      '${event.lines.join('\n')}\n',
      mode: FileMode.append,
    );
  }

  @override
  void output(OutputEvent event) {
    _lock.synchronized(() {
      return write(event);
    });
  }
}
