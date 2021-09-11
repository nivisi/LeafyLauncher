import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/page_base.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'intro_controller.dart';
import 'widget/hello_and_welcome.dart';

class IntroPage extends PageBase<IntroController, HomeTheme> {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget pageBody(BuildContext context, LeafyTheme theme) {
    return const HelloAndWelcome();
  }
}
