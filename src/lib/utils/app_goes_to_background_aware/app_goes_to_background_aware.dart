import 'package:flutter/material.dart';

class AppGoesToBackgroundListener extends WidgetsBindingObserver {
  AppGoesToBackgroundListener(this._onGoesToBackground) {
    WidgetsBinding.instance!.addObserver(this);
  }

  bool _disposed = false;
  VoidCallback? _onGoesToBackground;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_disposed && state == AppLifecycleState.paused) {
      _onGoesToBackground?.call();
    }
  }

  void dispose() {
    if (!_disposed) {
      WidgetsBinding.instance!.removeObserver(this);
      _disposed = true;
      _onGoesToBackground = null;
    }
  }
}
