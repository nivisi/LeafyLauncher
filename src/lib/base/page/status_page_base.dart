import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/app_constants.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../shared_widget/loader.dart';
import '../controller/status_controller_base.dart';
import 'page_base.dart';

abstract class StatusPageBase<T extends StatusControllerBase,
    TTheme extends LeafyTheme> extends PageBase<T, TTheme> {
  const StatusPageBase();

  Widget loading(BuildContext context, LeafyTheme theme) {
    return const Center(child: Loader());
  }

  Widget error(BuildContext context, LeafyTheme theme, ControllerError? error) {
    if (error != null) {
      return Center(child: Text(error.toString()));
    }

    return Center(
      child: Text('Something went wrong ... \n ${error?.toString() ?? ''}'),
    );
  }

  Widget ready(BuildContext context, LeafyTheme theme);

  @override
  Widget pageBody(BuildContext context, LeafyTheme theme) {
    return AnimatedSwitcher(
      duration: kDefaultAnimationDuration,
      child: GetBuilder<T>(
        key: ValueKey(controller.status),
        id: StatusControllerBase.statusGetKey,
        init: controller,
        builder: (controller) {
          if (controller.isReady) {
            return ready(context, theme);
          } else if (controller.isLoading) {
            return loading(context, theme);
          } else if (controller.isError) {
            return error(context, theme, controller.error);
          } else {
            throw Exception('Page had an unknown status');
          }
        },
      ),
    );
  }
}
