import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'applications/notes/leafy_notes.dart';

const _appChannel = MethodChannel('com.nivisi.leafy_launcher/app');

// For a reason we cannot create another entry point,
// so we need to distinguish the app by calling a method channel.

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
