import 'package:flutter/material.dart';
import 'package:notification_builder/notification_builder.dart';

import 'home/leafy_home_theme_data_bright.dart';
import 'home/leafy_home_theme_data_dark.dart';
import 'leafy_theme_data.dart';

class _LeafyThemeInherited extends InheritedWidget {
  const _LeafyThemeInherited({
    Key? key,
    required Widget child,
    required this.themeData,
  }) : super(key: key, child: child);

  final LeafyThemeData themeData;

  @override
  bool updateShouldNotify(covariant _LeafyThemeInherited oldWidget) {
    return themeData != oldWidget.themeData;
  }
}

class LeafyThemeNew extends StatefulWidget {
  const LeafyThemeNew({
    Key? key,
    required this.themeData,
    required this.child,
  }) : super(key: key);

  const LeafyThemeNew.homeDark({
    Key? key,
    required this.child,
  })  : themeData = homeThemeDark,
        super(key: key);

  const LeafyThemeNew.homeBright({
    Key? key,
    required this.child,
  })  : themeData = homeThemeBright,
        super(key: key);

  final LeafyThemeData themeData;
  final Widget child;

  @override
  State<LeafyThemeNew> createState() => _LeafyThemeNewState();

  static LeafyThemeData of(BuildContext context) {
    final data = context
        .dependOnInheritedWidgetOfExactType<_LeafyThemeInherited>()
        ?.themeData;

    assert(data != null);

    return data!;
  }

  static void setType(BuildContext context, LeafyThemeType type) {
    _ChangeLeafyThemeNotification(type).dispatch(context);
  }
}

class _LeafyThemeNewState extends State<LeafyThemeNew> {
  @override
  Widget build(BuildContext context) {
    return NotificationBuilder<_ChangeLeafyThemeNotification>(
      builder: (context, notification, child) {
        final type = notification?.type ?? LeafyThemeType.dark;
        final themeData =
            type == LeafyThemeType.bright ? homeThemeBright : homeThemeDark;

        return _LeafyThemeInherited(
          themeData: themeData,
          child: widget.child,
        );
      },
    );
  }
}

extension LeafyThemeBuildContext on BuildContext {
  LeafyThemeData get leafyTheme {
    return LeafyThemeNew.of(this);
  }
}

class _ChangeLeafyThemeNotification extends Notification {
  final LeafyThemeType type;

  _ChangeLeafyThemeNotification(this.type);
}
