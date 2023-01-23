import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/main/home_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/system_apps/home_system_apps_controller.dart';

class HomeControllersProvider extends StatelessWidget {
  const HomeControllersProvider({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return XMultiProvider(
      providers: [
        XProvider(
          create: (_) => injector<HomeApplicationsController>(),
        ),
        XProvider(
          create: (_) => injector<HomeController>(),
        ),
        XProvider(
          create: (_) => injector<HomeWidgetsController>(),
        ),
        XProvider(
          create: (_) => injector<HomeSystemAppsController>(),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
