import 'package:flutter/material.dart';

class SettingsAboutInherited extends InheritedWidget {
  const SettingsAboutInherited({
    super.key,
    required this.scrollController,
    required super.child,
  });

  final ScrollController scrollController;

  @override
  bool updateShouldNotify(covariant SettingsAboutInherited oldWidget) {
    return scrollController != oldWidget.scrollController;
  }

  static SettingsAboutInherited of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingsAboutInherited>()!;
  }
}
