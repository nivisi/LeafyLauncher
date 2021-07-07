import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/app_constants.dart';
import '../../../services/applications/user_applications_controller.dart';
import '../../../shared_widget/leafy_spacer.dart';
import '../../../utils/enum/user_selected_app_type.dart';
import '../../home/widget/user_app_button.dart';

class LeftAndRightAppsList extends GetView<UserApplicationsController> {
  static const double _spacerMultipler = 2.0;

  const LeftAndRightAppsList({Key? key}) : super(key: key);

  GetBuilder _getBuilderForApp(UserSelectedAppType type) {
    return GetBuilder<UserApplicationsController>(
      id: controller.getBuilderId(type),
      init: controller,
      builder: (controller) {
        return UserAppButton(
          application: controller.getApp(type),
          onTapped: (application) {
            controller.selectApp(type);
          },
          onLongPress: () {
            controller.selectApp(type);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBuilderForApp(UserSelectedAppType.left),
          const LeafySpacer(multipler: _spacerMultipler),
          _getBuilderForApp(UserSelectedAppType.right),
        ],
      ),
    );
  }
}
