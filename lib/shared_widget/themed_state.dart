import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../resources/theme/leafy_theme.dart';

abstract class ThemedState<TWidget extends StatefulWidget,
    TTheme extends LeafyTheme> extends State<TWidget> {
  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TTheme>();

    if (theme == null) {
      return const Text('THEME NOT FOUND!');
    }

    return body(context, theme);
  }

  Widget body(BuildContext context, TTheme theme);
}
