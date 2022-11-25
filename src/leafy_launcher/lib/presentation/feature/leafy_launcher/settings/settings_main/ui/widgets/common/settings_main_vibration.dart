import 'package:flutter/widgets.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainVibration extends StatelessWidget {
  const SettingsMainVibration({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsMainController;
    final vibrationPreferences = controller.state.watch.vibrationPreferences;

    return LeafySectionTextItem(
      title: LeafyL10n.vibrationPreferences,
      value: LeafySectionTextValue(value: vibrationPreferences.l10n),
      onTap: () async {
        Option<VibrationPreferences>? selectedOption;

        final options = VibrationPreferences.values.map((preference) {
          final title = preference.l10n;

          final option = Option(title: title, value: preference);

          if (vibrationPreferences == preference) {
            selectedOption = option;
          }

          return option;
        }).toList();

        final selected = await OptionsPicker.show<VibrationPreferences>(
          context,
          selectedOption: selectedOption,
          options: options,
        );

        if (selected != null) {
          controller.raiseEvent.selectVibrationPreferences(selected);
        }
      },
    );
  }
}
