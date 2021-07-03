import 'package:flutter/material.dart';

import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/application.dart';
import '../../../shared_widget/themed_widget.dart';
import '../../../shared_widget/touchable_text_button.dart';

class UserAppButton extends ThemedWidget<HomeTheme> {
  final Application? _application;
  final void Function(Application? application) _onTapped;
  final void Function() _onLongPress;

  const UserAppButton({
    Key? key,
    required Application? application,
    required void Function(Application? application) onTapped,
    required void Function() onLongPress,
  })  : _application = application,
        _onTapped = onTapped,
        _onLongPress = onLongPress,
        super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return TouchableTextButton(
      text: _application?.name ?? 'Select',
      style: theme.bodyText1,
      pressedColor: theme.foregroundPressedColor,
      color: theme.foregroundColor,
      onTap: () {
        _onTapped(_application);
      },
      onLongPress: _onLongPress,
    );
  }
}
