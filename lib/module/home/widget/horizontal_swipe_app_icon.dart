import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/user_applications_controller.dart';
import '../../../shared_widget/themed_get_widget.dart';
import '../../../utils/enum/user_selected_app_type.dart';

class HorizontalSwipeAppIcon
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const HorizontalSwipeAppIcon({
    Key? key,
    required this.appType,
  }) : super(key: key);

  final UserSelectedAppType appType;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      margin: const EdgeInsets.all(5.0),
      child: GetBuilder<UserApplicationsController>(
        init: controller,
        id: controller.getBuilderId(appType),
        builder: (controller) {
          final icon = appType == UserSelectedAppType.left
              ? controller.leftAppIcon
              : controller.rightAppIcon;

          return icon == null
              ? Icon(
                  Icons.settings,
                  color: theme.foregroundColor,
                  size: 40,
                )
              : Image.memory(icon);
        },
      ),
    );
  }
}
