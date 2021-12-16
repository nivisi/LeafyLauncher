import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'applications/notes/leafy_notes.dart';

const _appChannel = MethodChannel('com.nivisi.leafy_launcher/app');

@pragma('vm:entry-point')
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await _appChannel.invokeMethod('app');

  switch (app) {
    case 'launcher':
      return LeafyLauncher.run();
    case 'leafyNotes':
      return LeafyNotes.run();
  }

  throw Exception('Tried to launch an unknown app!');
}
