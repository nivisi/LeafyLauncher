import 'package:flutter/services.dart';

class DeviceVibration {
  const DeviceVibration();

  Future weak() async {
    return HapticFeedback.selectionClick();
  }
}
