import 'dart:async';

class DateChangedListener {
  DateChangedListener() {
    init();
  }

  late Timer _timer;

  DateTime _lastKnownDate = DateTime.now();

  final _controller = StreamController<void>.broadcast();
  Stream<void> get onDateChanged => _controller.stream;

  void init() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final now = DateTime.now();

        if (_lastKnownDate.day != now.day) {
          _controller.add(null);
        }

        _lastKnownDate = now;
      },
    );
  }

  void dispose() {
    _timer.cancel();
  }
}
