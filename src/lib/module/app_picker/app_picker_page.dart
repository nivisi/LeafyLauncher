import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/localization/l10n.dart';
import '../../resources/localization/l10n_provider.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'app_picker_controller.dart';
import 'app_picker_controller_base.dart';
import 'widget/app_picker.dart';

class AppPickerPage extends StatusPageBase<AppPickerController, HomeTheme> {
  const AppPickerPage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    final String title;

    switch (controller.type) {
      case UserSelectedAppType.first:
      case UserSelectedAppType.second:
      case UserSelectedAppType.third:
      case UserSelectedAppType.fourth:
        final select = L10nProvider.getText(L10n.appPickerSelect);
        final app = L10nProvider.getText(L10n.appPickerApp);

        title = '$select ${controller.type!.localize()} $app';
        break;
      case UserSelectedAppType.left:
      case UserSelectedAppType.right:
        final select = L10nProvider.getText(L10n.appPickerSelect);
        final to = L10nProvider.getText(L10n.appPickerTo);
        final app = L10nProvider.getText(L10n.appPickerApp);

        title = '''$select $to ${controller.type!.localize()} $app''';
        break;
      case null:
        title = L10nProvider.getText(L10n.appPickerLaunchApp);
        break;
      default:
        throw Exception('Unknown UserSelectedAppType');
    }

    return GetBuilder<AppPickerController>(
      id: AppPickerControllerBase.appListBuilderKey,
      init: controller,
      builder: (controller) {
        return AppPicker(
          title: title,
          autofocusTextField: true,
          textFieldFocusNode: controller.textFocusNode,
          textEditingController: controller.textEditingController,
          scrollController: controller.scrollController,
          applications: controller.apps,
          onAppSelected: controller.onAppSelected,
        );
      },
    );
  }
}
