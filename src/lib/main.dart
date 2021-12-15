import 'package:flutter/material.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'applications/notes/leafy_notes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LeafyLauncher.run();
}

void mainNotes() {
  WidgetsFlutterBinding.ensureInitialized();

  LeafyNotes.run();
}
