import 'package:flutter/material.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'applications/notes/leafy_notes.dart';

@pragma('vm:entry-point')
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LeafyLauncher.run();
}

@pragma('vm:entry-point')
void mainNotes() {
  WidgetsFlutterBinding.ensureInitialized();

  LeafyNotes.run();
}
