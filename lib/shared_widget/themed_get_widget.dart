import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/theme/leafy_theme.dart';

abstract class ThemedGetWidget<TController extends GetxController,
        TTheme extends LeafyTheme> extends StatelessWidget
    implements GetView<TController> {
  final String? tag = null;

  TController get controller => GetInstance().find<TController>(tag: tag);

  const ThemedGetWidget({Key? key}) : super(key: key);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TTheme>();

    if (theme == null) {
      return const Text('THEME NOT FOUND!');
    }

    return body(context, theme);
  }

  Widget body(BuildContext context, LeafyTheme theme);
}
