import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/controller/settings_home_widgets_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsTimeProgressTypeSectionItem extends StatelessWidget {
  const SettingsTimeProgressTypeSectionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsHomeWidgetsController;
    final selectedType = controller.state.watch.timeProgressType;
    final sectionValue = selectedType.l10n;

    return LeafySectionTextItem(
      title: LeafyL10n.settingsTimeProgressType,
      value: LeafySectionTextValue(value: sectionValue),
      onTap: () async {
        Option<TimeProgressType>? selectedOption;

        final options = TimeProgressType.values.map((e) {
          final title = e.l10n;

          final option = Option(
            title: title,
            value: e,
            isDestructive: e == TimeProgressType.disabled,
          );

          if (e == selectedType) {
            selectedOption = option;
          }

          return option;
        }).toList();

        final selected = await OptionsPicker.show<TimeProgressType>(
          context,
          selectedOption: selectedOption,
          options: options,
        );

        if (selected != null) {
          controller.raiseEvent.setTimeProgressType(selected);
        }
      },
    );
  }
}
