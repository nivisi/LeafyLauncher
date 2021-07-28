import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeButtonListener {
  static const _channel = EventChannel(
    'com.nivisi.leafy_launcher/homePressedChannel',
  );

  static final Stream _stream = _channel.receiveBroadcastStream();

  const HomeButtonListener();

  StreamSubscription addCallback(VoidCallback callback) {
    return _stream.listen(
      (_) {
        callback();
      },
    );
  }
}
