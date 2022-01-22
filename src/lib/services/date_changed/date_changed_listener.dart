import 'dart:async';

import 'package:flutter/services.dart';

const _dateChangedChannel = EventChannel(
  'com.nivisi.leafy_launcher/dateChangedChannel',
);

class DateChangedListener {
  DateChangedListener() {
    init();
  }

  final _controller = StreamController<void>.broadcast();
  Stream<void> get onDateChanged => _controller.stream;

  late StreamSubscription _subscription;

  void init() {
    _subscription =
        _dateChangedChannel.receiveBroadcastStream().listen(_onDateChanged);
  }

  void _onDateChanged(_) {
    _controller.add(null);
  }

  void dispose() {
    _subscription.cancel();
  }
}
