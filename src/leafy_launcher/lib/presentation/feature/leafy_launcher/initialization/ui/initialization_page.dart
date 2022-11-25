import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/initialization/controller/initialization_controller.dart';

import 'initialization_body.dart';
import 'initialization_listener.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return XProvider(
      create: (_) => injector<InitializationController>(),
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: InitializationListener(
          child: InitializationBody(),
        ),
      ),
    );
  }
}
