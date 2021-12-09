import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import '../themed_widget.dart';

abstract class MenuItem {
  const MenuItem();
}

class MenuSeparator extends MenuItem {
  const MenuSeparator();
}

class MenuAction extends MenuItem {
  MenuAction({required this.action, required this.title});

  final VoidCallback action;
  final String title;
}

class ContextMenuRoute<TTheme extends LeafyTheme> extends ModalRoute {
  ContextMenuRoute._(
    this.context,
    this.where,
    this.left,
    this.menuItems, {
    this.width = 250.0,
    this.height = 48.0,
  });

  final BuildContext context;
  final Offset where;
  final double left;
  final List<MenuItem> menuItems;
  final double width;
  final double height;

  static Future open<TTheme extends LeafyTheme>(
    BuildContext context,
    Offset where,
    double left,
    List<MenuItem> menuItems, {
    double width = 250.0,
    double height = 48.0,
  }) {
    return Navigator.of(context).push(
      ContextMenuRoute<TTheme>._(
        context,
        where,
        left,
        menuItems,
        width: width,
        height: height,
      ),
    );
  }

  double _getX() {
    var x = where.dx - width - 16.0;
    if (x <= left) {
      x = left;
    }
    return x;
  }

  double _getY() {
    return where.dy;
  }

  @override
  Color get barrierColor => kBarrierColor;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => kDefaultAnimationDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final actionsHeight = menuItems.whereType<MenuAction>().length * height;
    final separatorsHeight = menuItems.whereType<MenuSeparator>().length * 1;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          Positioned(
            left: _getX(),
            top: _getY(),
            child: FadeTransition(
              opacity: animation,
              child: LeafyThemeState<TTheme>(
                builder: (context, theme) {
                  return Container(
                    width: width,
                    height: actionsHeight + separatorsHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(theme.defaultRadius),
                      color: theme.secondaryBackgroundColor,
                    ),
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final item in menuItems)
                          if (item is MenuAction)
                            _MenuOption<TTheme>(
                              action: item,
                              width: width,
                              height: height,
                            )
                          else
                            _MenuSeparator<TTheme>(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuSeparator<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const _MenuSeparator();

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: ColoredBox(color: theme.separatorColor),
    );
  }
}

class _MenuOption<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const _MenuOption({
    required this.action,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final MenuAction action;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          primary: theme.foregroundColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
          action.action();
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            action.title,
            style: TextStyle(
              color: theme.foregroundColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
