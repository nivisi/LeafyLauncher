import 'package:flutter/services.dart';

class DeviceVibration {
  Future weak() async {
    return HapticFeedback.selectionClick();
  }
}
