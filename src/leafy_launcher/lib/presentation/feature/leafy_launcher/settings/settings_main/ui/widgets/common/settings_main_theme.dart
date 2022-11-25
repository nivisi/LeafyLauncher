import 'package:flutter/widgets.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/extensions/supported_theme_extensions.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainTheme extends StatelessWidget {
  const SettingsMainTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsMainController;
    final themeType = controller.state.watch.themeType;

    return LeafySectionTextItem(
      title: LeafyL10n.settingsTheme,
      value: LeafySectionTextValue(value: themeType.l10n),
      onTap: () async {
        Option<SupportedTheme>? selectedOption;

        final options = SupportedTheme.values.map((e) {
          final theme = e.toFlutterThemeType();
          final title = theme.l10n;

          final option = Option(title: title, value: e);

          if (theme == themeType) {
            selectedOption = option;
          }

          return option;
        }).toList();

        final selected = await OptionsPicker.show<SupportedTheme>(
          context,
          selectedOption: selectedOption,
          options: options,
        );

        if (selected != null) {
          controller.raiseEvent.selectTheme(selected);
        }
      },
    );
  }
}
