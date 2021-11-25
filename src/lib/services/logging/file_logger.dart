import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../file_system/file_system.dart';

class FileLogger {
  final _fileSystem = Get.find<FileSystem>();
  final _dateFormatter = DateFormat('dd.MM.yyyy');

  File getFileForToday() {
    final today = DateTime.now();
    final fileName =
        '''${_fileSystem.loggingDirectory.path}/log${_dateFormatter.format(today)}.log''';
    final file = File(fileName);
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }
}
