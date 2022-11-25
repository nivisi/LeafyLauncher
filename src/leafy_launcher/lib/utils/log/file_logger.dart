import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/services/file_system/file_system.dart';

@lazySingleton
class FileLogger {
  final _fileSystem = injector<FileSystem>();
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
