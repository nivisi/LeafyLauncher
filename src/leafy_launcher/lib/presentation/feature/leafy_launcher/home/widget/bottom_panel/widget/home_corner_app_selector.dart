import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';
import 'package:provider/provider.dart';

class HomeCornerAppSelector extends StatefulWidget {
  const HomeCornerAppSelector({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<HomeCornerAppSelector> createState() => _HomeCornerAppSelectorState();
}

class _HomeCornerAppSelectorState extends State<HomeCornerAppSelector> {
  bool _isPresented = false;
  late List<CornerApp> _others;
  late CornerAppPosition _position;
  late ValueChanged<CornerApp> _onSelected;

  void _onSelectLauncher(
    CornerAppPosition position,
    CornerApp selectedApp,
    ValueChanged<CornerApp> onSelected,
  ) {
    setState(() {
      _position = position;
      _isPresented = true;
      _onSelected = onSelected;
      _others = CornerApp.values.where((e) => e != selectedApp).toList();
    });
  }

  void _dismiss() {
    setState(() {
      _isPresented = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HomeCornerAppSelectorProvider._(_onSelectLauncher),
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        return Stack(
          children: [
            widget.child,
            IgnorePointer(
              ignoring: !_isPresented,
              child: AnimatedSwitcher(
                duration: kDefaultAnimationDuration,
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.fastOutSlowIn,
                child: !_isPresented
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: _dismiss,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height,
                              child: ColoredBox(
                                color: Colors.black.withOpacity(.75),
                                child: const SizedBox(),
                              ),
                            ),
                            _CornerAppSelector(
                              position: _position,
                              apps: _others,
                              onSelected: (app) {
                                _dismiss();
                                _onSelected(app);
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CornerAppSelector extends StatelessWidget {
  const _CornerAppSelector({
    Key? key,
    required this.position,
    required this.apps,
    required this.onSelected,
  }) : super(key: key);

  final CornerAppPosition position;
  final List<CornerApp> apps;
  final ValueChanged<CornerApp> onSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: position == CornerAppPosition.left ? 12.0 : null,
      right: position == CornerAppPosition.right ? 12.0 : null,
      child: Column(
        children: [
          for (final app in apps)
            HomeCornerApp(
              app: app,
              onPressed: () {
                onSelected(app);
              },
            ),
        ],
      ),
    );
  }
}

class HomeCornerAppSelectorProvider {
  const HomeCornerAppSelectorProvider._(this.callback);

  final void Function(
    CornerAppPosition position,
    CornerApp selectedApp,
    ValueChanged<CornerApp> onSelected,
  ) callback;

  void launchSelection(
    CornerAppPosition position,
    CornerApp selectedApp, {
    required ValueChanged<CornerApp> onSelected,
  }) {
    callback(position, selectedApp, onSelected);
  }
}

enum CornerAppPosition {
  left,
  right,
}
