import 'package:auto_route/auto_route.dart';
import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';
import 'package:leafy_launcher/presentation/extensions/supported_theme_extensions.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import '../controller/initialization_controller.dart';

class InitializationListener extends StatelessWidget {
  const InitializationListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = context.initializationController;

    return XListener(
      streamable: controller,
      listener: (context, effect) {
        if (effect is InitializationSetup) {
          LeafyLocalizedApp.setLocale(
            context,
            effect.locale.toFlutterLocale(),
          );
          LeafyThemeNew.setType(
            context,
            effect.theme.toFlutterThemeType(),
          );

          context.router.replace(const HomeRouteNew());
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          //   Future.delayed(const Duration(seconds: 1)).then(
          //     (value) => context.router.replace(const HomeRouteNew()),
          //   );
          // });
        }
      },
      child: child,
    );
  }
}
