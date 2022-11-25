import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';
import 'package:leafy_launcher/presentation/extensions/supported_theme_extensions.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainListener extends StatelessWidget {
  const SettingsMainListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsMainController;

    return XListener(
      streamable: controller,
      listener: (context, effect) {
        if (effect is SupportedLocale) {
          LeafyLocalizedApp.setLocale(context, effect.toFlutterLocale());
        } else if (effect is SupportedTheme) {
          LeafyThemeNew.setType(context, effect.toFlutterThemeType());
        }
      },
      child: child,
    );
  }
}
