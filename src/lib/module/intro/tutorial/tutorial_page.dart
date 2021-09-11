import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/page_base.dart';
import 'package:leafy_launcher/module/intro/tutorial/widget/tutorial.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'tutorial_controller.dart';

class TutorialPage extends PageBase<TutorialController, HomeTheme> {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget pageBody(BuildContext context, LeafyTheme theme) {
    return const Tutorial();
  }
}
