import 'package:flutter/material.dart';

import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/application.dart';
import '../../../shared_widget/themed_widget.dart';
import '../../../shared_widget/touchable_text_button.dart';

class AppPickerButton extends ThemedWidget<HomeTheme> {
  final Application application;
  final void Function(Application app) onTapped;

  const AppPickerButton({
    Key? key,
    required this.application,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return TouchableTextButton(
      text: application.name,
      color: theme.foregroundColor,
      pressedColor: theme.foregroundPressedColor,
      style: const TextStyle(fontSize: 26),
      onTap: () {
        onTapped(application);
      },
    );
  }
}
