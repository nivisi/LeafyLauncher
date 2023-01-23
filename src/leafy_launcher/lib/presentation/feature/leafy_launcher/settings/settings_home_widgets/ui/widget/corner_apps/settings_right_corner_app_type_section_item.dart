import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/controller/settings_home_widgets_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsRightCornerAppTypeSectionItem extends StatelessWidget {
  const SettingsRightCornerAppTypeSectionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsHomeWidgetsController;
    final selectedApp = controller.state.watch.rightCornerApp;
    final sectionValue = selectedApp.l10n;

    return LeafySectionTextItem(
      title: LeafyL10n.application,
      value: LeafySectionTextValue(value: sectionValue),
      onTap: () async {
        Option<CornerApp>? selectedOption;

        final options = CornerApp.values.map((e) {
          final title = e.l10n;

          final option = Option(
            title: title,
            value: e,
            isDestructive: e == CornerApp.disabled,
          );

          if (e == selectedApp) {
            selectedOption = option;
          }

          return option;
        }).toList();

        final selected = await OptionsPicker.show<CornerApp>(
          context,
          selectedOption: selectedOption,
          options: options,
        );

        if (selected != null) {
          controller.raiseEvent.setRightCornerApp(selected);
        }
      },
    );
  }
}
