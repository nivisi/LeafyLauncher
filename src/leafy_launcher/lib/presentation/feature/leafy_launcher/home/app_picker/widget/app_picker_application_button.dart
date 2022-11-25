import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller_new.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

enum _AppPickerOption {
  aboutApp,
  uninstall,
}

class AppPickerApplicationButton extends StatelessWidget {
  const AppPickerApplicationButton({
    Key? key,
    required this.application,
  }) : super(key: key);

  final ApplicationModelBase application;

  @override
  Widget build(BuildContext context) {
    final controller = context.appPickerControllerNew;
    final theme = context.leafyTheme;
    final application = this.application;

    return LeafyTouchableTextButton(
      application.name,
      style: theme.textStyles.bodyText1,
      color: theme.palette.foregroundColor,
      pressedColor: theme.palette.foregroundPressedColor,
      onLongPress: () async {
        FocusScope.of(context).unfocus();

        final uninstall = Option(
          title: LeafyL10n.actionDelete,
          value: _AppPickerOption.uninstall,
          isDestructive: true,
        );

        final aboutApp = Option(
          title: LeafyL10n.actionAboutApp,
          value: _AppPickerOption.aboutApp,
        );

        final selectedOption = await OptionsPicker.show(
          context,
          title: application.name,
          options: [
            aboutApp,
            if (application is InstalledApplicationModel &&
                !application.isSystem)
              uninstall,
          ],
        );

        if (selectedOption == _AppPickerOption.aboutApp) {
          controller.raiseEvent.openAboutApp(application);
        } else if (selectedOption == _AppPickerOption.uninstall) {
          controller.raiseEvent.uninstallApp(application);
        }
      },
      onTap: () {
        controller.raiseEvent.appSelected(application);
      },
    );
  }
}
