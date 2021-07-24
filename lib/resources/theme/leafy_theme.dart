import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../utils/enum/leafy_theme_style.dart';
import '../../utils/log/get_logger.dart';
import '../../utils/preferences/shared_preferences.dart';
import 'home_theme.dart';

part 'theme_creators.dart';

LeafyThemeStyle _currentStyle = LeafyThemeStyle.dark;

class LeafyThemeState<TTheme extends LeafyTheme> extends StatefulWidget {
  final Widget Function(BuildContext context, LeafyTheme theme) builder;

  const LeafyThemeState({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _LeafyThemeState<TTheme> createState() => _LeafyThemeState<TTheme>();
}

class _LeafyThemeState<TTheme extends LeafyTheme>
    extends State<LeafyThemeState> {
  late final StreamSubscription _styleChangedThemeSubscription;

  LeafyTheme _getTheme(BuildContext context) {
    final themeWidget = context.dependOnInheritedWidgetOfExactType<TTheme>();

    if (themeWidget == null) {
      throw Exception('Something went wrong!');
    }

    return themeWidget;
  }

  @override
  void initState() {
    super.initState();

    _styleChangedThemeSubscription = LeafyTheme.onStyleChanged(
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCreator = _creatorMap[TTheme];

    return themeCreator!(
      Builder(builder: (context) {
        final theme = _getTheme(context);

        return widget.builder(context, theme);
      }),
    );
  }

  @override
  void dispose() {
    _styleChangedThemeSubscription.cancel();

    super.dispose();
  }
}

abstract class LeafyTheme extends InheritedWidget {
  static Logger logger = getLogger(forObject: 'LeafyTheme');

  static LeafyThemeStyle get currentStyle => _currentStyle;

  final LeafyThemeStyle style;

  final Color leafyColor;
  final Color foregroundColor;
  final Color foregroundPressedColor;
  final Color backgroundColor;
  final Color textInfoColor;

  final TextStyle bodyText1;
  final TextStyle bodyText2;
  final TextStyle bodyText3;
  final TextStyle bodyText4;

  static final StreamController _controller = StreamController.broadcast();

  static StreamSubscription onStyleChanged(VoidCallback callback) {
    return _controller.stream.listen((_) {
      callback();
    });
  }

  const LeafyTheme({
    Key? key,
    required Widget child,
    required this.style,
    required this.leafyColor,
    required this.foregroundColor,
    required this.foregroundPressedColor,
    required this.backgroundColor,
    required this.textInfoColor,
    required this.bodyText1,
    required this.bodyText2,
    required this.bodyText3,
    required this.bodyText4,
  }) : super(key: key, child: child);

  @override
  @nonVirtual
  bool updateShouldNotify(covariant LeafyTheme oldWidget) {
    return style != oldWidget.style;
  }

  static void toggleTheme() {
    switch (_currentStyle) {
      case LeafyThemeStyle.light:
        _currentStyle = LeafyThemeStyle.dark;
        break;
      case LeafyThemeStyle.dark:
        _currentStyle = LeafyThemeStyle.light;
        break;
      default:
        throw 'Unknown type';
    }

    sharedPreferences.setString(
      kThemeStyleKey,
      stringifyLeafyThemeStyle(_currentStyle),
    );

    _controller.add(null);
  }

  static void restoreThemeStyle() {
    final style = sharedPreferences.getString(kThemeStyleKey);

    if (style == null) {
      _currentStyle = LeafyThemeStyle.dark;
      return;
    }

    try {
      _currentStyle = leafyThemeStyleFromString(style);
    } on Exception catch (e) {
      _currentStyle = LeafyThemeStyle.dark;
      logger.e('Unable to restore theme style', e);
    }
  }
}
