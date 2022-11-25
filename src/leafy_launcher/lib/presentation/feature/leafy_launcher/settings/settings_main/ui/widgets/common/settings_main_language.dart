import 'package:flutter/widgets.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainLanguage extends StatelessWidget {
  const SettingsMainLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsMainController;
    final language = controller.state.watch.language;

    return LeafySectionTextItem(
      title: LeafyL10n.settingsLanguage,
      value: LeafySectionTextValue(value: language.l10n),
      onTap: () async {
        Option<SupportedLocale>? selectedOption;

        final options = SupportedLocale.values.map((e) {
          final locale = e.toFlutterLocale();
          final title = locale.l10n;

          final option = Option(title: title, value: e);

          if (locale == language) {
            selectedOption = option;
          }

          return option;
        }).toList();

        final selected = await OptionsPicker.show<SupportedLocale>(
          context,
          selectedOption: selectedOption,
          options: options,
        );

        if (selected != null) {
          controller.raiseEvent.selectLanguage(selected);
        }
      },
    );
  }
}
