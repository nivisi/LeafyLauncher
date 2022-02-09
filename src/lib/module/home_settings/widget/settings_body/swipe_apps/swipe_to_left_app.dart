import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/shared_widget/section/src/items/leafy_section_text_item.dart';

import '../../../../../resources/localization/l10n.dart';
import '../../../../../resources/localization/l10n_provider.dart';
import '../../../../../resources/theme/home_theme.dart';
import '../../../../../services/applications/user_applications_controller.dart';
import '../../../../../shared_widget/section/src/items/values/leafy_section_text_value.dart';
import '../../../../../utils/enum/user_selected_app_type.dart';

class SwipeToLeftApp extends GetWidget<UserApplicationsController> {
  const SwipeToLeftApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsToLeftApp),
      onTap: () => controller.selectApp(UserSelectedAppType.left),
      value: GetBuilder<UserApplicationsController>(
        id: controller.getBuilderId(UserSelectedAppType.left),
        init: controller,
        builder: (controller) {
          final app = controller.getApp(UserSelectedAppType.left);

          return LeafySectionTextValue<HomeTheme>(
            value: app?.name ?? L10nProvider.getText(L10n.homeSelectApp),
          );
        },
      ),
    );
  }
}
