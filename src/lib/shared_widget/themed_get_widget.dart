import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/theme/leafy_theme.dart';

abstract class ThemedGetWidget<TController extends GetxController,
    TTheme extends LeafyTheme> extends GetView<TController> {
  const ThemedGetWidget({Key? key}) : super(key: key);

  @override
  TController get controller => GetInstance().find<TController>(tag: tag);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TTheme>();

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
