import 'package:flutter/services.dart';

class LeafySystemOverlayObserver {
  static bool _isEnabled = false;

  static void _showTopOverlay() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
  }

  static void _hideTopOverlay() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  static void enable() {
    _isEnabled = true;

    _hideTopOverlay();
  }

  static void disable() {
    _isEnabled = false;

    _showTopOverlay();
  }

  static void configure() {
    enable();

    _hideTopOverlay();

    SystemChrome.setSystemUIChangeCallback(
      (systemOverlaysAreVisible) async {
        if (systemOverlaysAreVisible) {
          return;
        }

        if (!_isEnabled) {
          return;
        }

        await Future.delayed(const Duration(seconds: 2));

        _hideTopOverlay();
      },
    );
  }
}
