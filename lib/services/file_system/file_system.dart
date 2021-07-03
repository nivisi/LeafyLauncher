import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystem {
  FileSystem._();

  static FileSystem? _instance;

  late final Directory _appDocumentsDirectory;
  late final Directory _loggingDirectory;

  Directory get appDocumentsDirectory => _appDocumentsDirectory;

  Directory get loggingDirectory {
    if (!_loggingDirectory.existsSync()) {
      _loggingDirectory.createSync();
    }
    return _loggingDirectory;
  }

  void _initLoggingDirectory() {
    final loggingDirectoryPath = '${_appDocumentsDirectory.path}/logging';
    _loggingDirectory = Directory(loggingDirectoryPath);
  }

  Future _init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();

    _initLoggingDirectory();
  }

  static Future<FileSystem> init() async {
    if (_instance != null) {
      return _instance!;
    }

    final fileSystem = FileSystem._();
    await fileSystem._init();

    return _instance = fileSystem;
  }
}
