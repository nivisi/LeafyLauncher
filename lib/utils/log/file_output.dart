import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:synchronized/synchronized.dart';

import '../../services/logging/file_logger.dart';

class FileOutput extends LogOutput {
  final _fileLogService = Get.find<FileLogger>();

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
