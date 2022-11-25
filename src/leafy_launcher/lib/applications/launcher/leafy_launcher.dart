import 'package:auto_route/auto_route.dart';
import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/configs/contact_links_config.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/all_applications/controller/all_apps_controller.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import '../../utils/app_flavour/app_flavour.dart';

class LeafyLauncher {
  static final _appRouter = LeafyRouter();

  static Future run(
    AppFlavour flavour,
    ContactLinksConfig contactLinksConfig,
  ) async {
    await configureDependencies(flavour, contactLinksConfig);

    // await initPrimaryDependencies(flavour);
    // initSecondaryDependencies();

    // LeafyTheme.restoreThemeStyle();

    // await LeafySettings.restore();

    // L10n.restore();

    Paint.enableDithering = true;

    runApp(
      MaterialApp.router(
        title: 'Leafy Launcher',
        routerDelegate: AutoRouterDelegate(_appRouter),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeData(
          splashFactory: InkRipple.splashFactory,
        ),
        builder: (context, child) {
          if (child == null) {
            return const SizedBox();
          }

          return LeafyLocalizedApp(
            child: XProvider(
              create: (_) => injector<AllAppsController>(),
              child: LeafyThemeNew.homeDark(
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
