import 'package:flutter/material.dart';

import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/application.dart';
import '../../../shared_widget/themed_widget.dart';
import '../../../shared_widget/touchable_text_button.dart';

class AppPickerButton extends ThemedWidget<HomeTheme> {
  const AppPickerButton({
    Key? key,
    required this.application,
    required this.onTapped,
    this.onLongPress,
  }) : super(key: key);

  final Application application;
  final void Function(Application app) onTapped;
  final void Function(Application app)? onLongPress;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return TouchableTextButton(
      text: application.name,
      color: theme.foregroundColor,
      pressedColor: theme.foregroundPressedColor,
      style: theme.bodyText1,
      onTap: () {
        onTapped(application);
      },
      onLongPress: onLongPress == null
          ? null
          : () {
              onLongPress!(application);
            },
    );
  }
}
