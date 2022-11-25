import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class FileSystem {
  FileSystem._();

  late final Directory _appDocumentsDirectory;
  late final Directory _loggingDirectory;
  late final Directory _leafyNotesDocumentsDirectory;

  Directory get appDocumentsDirectory => _appDocumentsDirectory;

  Directory get loggingDirectory {
    if (!_loggingDirectory.existsSync()) {
      _loggingDirectory.createSync();
    }
    return _loggingDirectory;
  }

  Directory get leafyNotesDocumentsDirectory {
    if (!_leafyNotesDocumentsDirectory.existsSync()) {
      _leafyNotesDocumentsDirectory.createSync();
    }
    return _leafyNotesDocumentsDirectory;
  }

  void _initLoggingDirectory() {
    final loggingDirectoryPath = '${_appDocumentsDirectory.path}/Logging';
    _loggingDirectory = Directory(loggingDirectoryPath);
  }

  void _initLeafyNotesDirectory() {
    final leafyNotesDirectoryPath = '${_appDocumentsDirectory.path}/LeafyNotes';
    _leafyNotesDocumentsDirectory = Directory(leafyNotesDirectoryPath);
  }

  Future _init() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();

    _initLoggingDirectory();
    _initLeafyNotesDirectory();
  }

  static Future<FileSystem> init() async {
    final fileSystem = FileSystem._();
    await fileSystem._init();
    return fileSystem;
  }
}
