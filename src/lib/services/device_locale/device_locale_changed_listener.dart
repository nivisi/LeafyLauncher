import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _deviceLocaleChangedChannel = EventChannel(
  'com.nivisi.leafy_launcher/deviceLocaleChangedChannel',
);

class DeviceLocaleChangedListener {
  DeviceLocaleChangedListener() {
    init();
  }

  final _controller = StreamController<Locale>.broadcast();
  Stream<Locale> get onDeviceLocaleChanged => _controller.stream;

  late StreamSubscription _subscription;

  void init() {
    _subscription = _deviceLocaleChangedChannel
        .receiveBroadcastStream()
        .listen(_onLocaleChanged);
  }

  void _onLocaleChanged(event) {
    if (event is! String) {
      throw Exception('event must be a string');
    }

    final split = event.split('-');

    final locale = Locale(split[0], split[1]);

    _controller.add(locale);
  }

  void dispose() {
    _subscription.cancel();
  }
}
