import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/controller/settings_home_widgets_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsClockIsEnabledSectionItem extends StatelessWidget {
  const SettingsClockIsEnabledSectionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsHomeWidgetsController;
    final isEnabled = controller.state.watch.isClockEnabled;
    final sectionValue = isEnabled
        ? LeafyL10n.settingsSectionEnabled
        : LeafyL10n.settingsSectionDisabled;

    return LeafySectionTextItem(
      title: LeafyL10n.settingsSectionIsEnabled,
      value: LeafySectionTextValue(value: sectionValue),
      onTap: () async {
        final trueOption =
            Option(title: LeafyL10n.settingsSectionEnabled, value: true);
        final falseOption =
            Option(title: LeafyL10n.settingsSectionDisabled, value: false);
        final selectedOption = isEnabled ? trueOption : falseOption;

        final selectedIsEnabled = await OptionsPicker.show(
          context,
          options: [trueOption, falseOption],
          selectedOption: selectedOption,
        );

        if (selectedIsEnabled != null) {
          controller.raiseEvent.setIsClockEnabled(selectedIsEnabled);
        }
      },
    );
  }
}
