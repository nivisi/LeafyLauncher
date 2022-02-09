import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../resources/theme/leafy_theme.dart';

abstract class ThemedWidget<T extends LeafyTheme> extends StatelessWidget {
  const ThemedWidget({Key? key}) : super(key: key);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<T>();

    assert(theme != null);

    if (theme == null) {
      return const ColoredBox(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('THEME NOT FOUND!'),
        ),
      );
    }

    return body(context, theme);
  }

  Widget body(BuildContext context, LeafyTheme theme);
}
