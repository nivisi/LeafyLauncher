import 'package:flutter/material.dart';

class SettingsMainInherited extends InheritedWidget {
  const SettingsMainInherited({
    super.key,
    required this.scrollController,
    required super.child,
  });

  final ScrollController scrollController;

  @override
  bool updateShouldNotify(covariant SettingsMainInherited oldWidget) {
    return scrollController != oldWidget.scrollController;
  }

  static SettingsMainInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingsMainInherited>()!;
  }
}
