import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leafy_launcher/presentation/configs/contact_links_config.dart';

import 'applications/launcher/leafy_launcher.dart';
import 'utils/app_flavour/app_flavour.dart';

const _appChannel = MethodChannel('com.nivisi.leafy_launcher/app');

void main() => mainCommon(AppFlavour.dev);

Future mainCommon(AppFlavour flavour) async {
  WidgetsFlutterBinding.ensureInitialized();

  // For a reason we cannot create another entry point for notes,
  // so we need to distinguish the app by calling a method channel.

  final contacts =
      await rootBundle.loadString('assets/config/contact_links.json');

  final json = jsonDecode(contacts) as Map<String, dynamic>;

  final contactsConfig = ContactLinksConfig.fromJson(json);

  final app = await _appChannel.invokeMethod('app');

  switch (app) {
    case 'launcher':
      return LeafyLauncher.run(flavour, contactsConfig);
    case 'leafyNotes':
      // TODO: Launch notes!
      return LeafyLauncher.run(flavour, contactsConfig);
  }

  throw Exception('Tried to launch an unknown app!');
}
