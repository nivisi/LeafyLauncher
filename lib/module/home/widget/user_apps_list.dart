import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

import '../../../services/applications/user_applications_controller.dart';
import '../../../shared_widget/leafy_spacer.dart';
import '../../../utils/enum/user_selected_app_type.dart';
import 'user_app_button.dart';

class _AppBuilder extends StatelessWidget {
  const _AppBuilder({
    Key? key,
    required this.type,
    required this.controller,
  }) : super(key: key);

  final UserSelectedAppType type;
  final UserApplicationsController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserApplicationsController>(
      id: controller.getBuilderId(type),
      init: controller,
      builder: (controller) {
        return UserAppButton(
          application: controller.getApp(type),
          onTapped: (application) {
            if (application == null) {
              controller.selectApp(type);
            } else {
              controller.launchApp(application);
            }
          },
          onLongPress: () {
            controller.selectApp(type);
          },
        );
      },
    );
  }
}

class UserAppsList extends GetView<UserApplicationsController> {
  const UserAppsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AppBuilder(type: UserSelectedAppType.first, controller: controller),
        const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
        _AppBuilder(type: UserSelectedAppType.second, controller: controller),
        const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
        _AppBuilder(type: UserSelectedAppType.third, controller: controller),
        const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
        _AppBuilder(type: UserSelectedAppType.fourth, controller: controller),
      ],
    );
  }
}
