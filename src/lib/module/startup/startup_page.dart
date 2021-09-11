import 'package:flutter/material.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import 'startup_controller.dart';

class StartupPage extends StatusPageBase<StartupController, HomeTheme> {
  const StartupPage();

  @override
  Widget loading(BuildContext context, LeafyTheme theme) {
    return Center(
      child: Text(
        'Loading applications ...',
        style: theme.bodyText3,
      ),
    );
  }

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return const Center(child: Text('Im the startup page'));
  }
}
