import 'dart:async';

import 'package:get/get.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/services/applications/installed_application.dart';
import 'package:leafy_launcher/services/device_vibration/device_vibration.dart';
import 'package:leafy_launcher/utils/dialogs/confirm/actions_dialog.dart';
import 'package:leafy_launcher/utils/dialogs/leafy_dialog.dart';

import '../../services/applications/application.dart';
import 'app_picker_controller_base.dart';

class AppPickerHomeController extends AppPickerControllerBase {
  AppPickerHomeController() : super(selectOnFirstMatch: true, type: null);

  final StreamController _backButtonController = StreamController.broadcast();

  late final DeviceVibration _deviceVibration;

  Stream get onAppSelectedEvent => _backButtonController.stream;

  @override
  Future resolveDependencies() async {
    await super.resolveDependencies();

    _deviceVibration = Get.find<DeviceVibration>();
  }

  @override
  Future onAppSelected(Application app) {
    _backButtonController.add(null);
    return installedApplicationsService.launch(app);
  }

  Future onAppLongPressed(Application app) async {
    if (app is! InstalledApplication) {
      return;
    }

    if (textFocusNode.hasFocus) {
      textFocusNode.unfocus();

      await Future.delayed(const Duration(milliseconds: 75));
    }

    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }

    final result = await ActionsDialog.show<HomeTheme, _LongPressActions>(
      title: app.name,
      options: [
        LeafyDialogOption.positive(
          title: L10nProvider.getText(
            L10n.actionAboutApp,
          ),
          callback: () {
            return _LongPressActions.view;
          },
        ),
        if (!app.isSystem)
          LeafyDialogOption.negative(
            title: L10nProvider.getText(
              L10n.actionDelete,
            ),
            callback: () {
              return _LongPressActions.delete;
            },
          ),
        LeafyDialogOption.neutral(
          title: L10nProvider.getText(
            L10n.actionCancel,
          ),
          callback: () {
            return _LongPressActions.cancel;
          },
        ),
      ],
      fallbackResult: _LongPressActions.cancel,
    );

    switch (result) {
      case _LongPressActions.delete:
        await installedApplicationsService.deleteApp(app);

        break;
      case _LongPressActions.view:
        installedApplicationsService.viewInfo(app);

        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    _backButtonController.close();

    super.onClose();
  }
}

enum _LongPressActions {
  delete,
  view,
  cancel,
}
