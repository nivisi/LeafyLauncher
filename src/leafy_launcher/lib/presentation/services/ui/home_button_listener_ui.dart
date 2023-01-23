import 'dart:async';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeButtonListenerUi {
  const HomeButtonListenerUi();

  static const _channel = EventChannel(
    'com.nivisi.leafy_launcher/homePressedChannel',
  );

  static final Stream _stream = _channel.receiveBroadcastStream();

  StreamSubscription addCallback(VoidCallback callback) {
    return _stream.listen(
      (_) {
        callback();
      },
    );
  }
}
