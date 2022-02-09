import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'applications/notes/leafy_notes.dart';
import 'utils/app_flavour/app_flavour.dart';

const _appChannel = MethodChannel('com.nivisi.leafy_launcher/app');

void main() => mainCommon(AppFlavour.dev);

Future mainCommon(AppFlavour flavour) async {
  WidgetsFlutterBinding.ensureInitialized();

  // For a reason we cannot create another entry point for notes,
  // so we need to distinguish the app by calling a method channel.

  final app = await _appChannel.invokeMethod('app');

  switch (app) {
    case 'launcher':
      return LeafyLauncher.run(flavour);
    case 'leafyNotes':
      return LeafyNotes.run(flavour);
  }

  throw Exception('Tried to launch an unknown app!');
}
