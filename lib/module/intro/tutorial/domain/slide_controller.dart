import 'dart:async';

import 'package:leafy_launcher/resources/app_constants.dart';

enum ScenarioEventType {
  init,
  forward,
  repeat,
  end,
}

enum SlideControllerState {
  onPause,
  playing,
}

class SlideController {
  final StreamController<ScenarioEventType> _eventController =
      StreamController<ScenarioEventType>.broadcast();
  final StreamController<void> _onDoneController =
      StreamController<void>.broadcast();

  bool _isDone = false;

  SlideControllerState state = SlideControllerState.onPause;

  Stream<ScenarioEventType> get widgetEvents => _eventController.stream;
  Stream<void> get onDone => _eventController.stream;

  void init() {
    state = SlideControllerState.onPause;

    _eventController.add(ScenarioEventType.init);
  }

  void forward() {
    state = SlideControllerState.playing;

    _eventController.add(ScenarioEventType.forward);
  }

  void repeat() {
    state = SlideControllerState.playing;

    _eventController.add(ScenarioEventType.repeat);
  }

  Future<void> end() {
    state = SlideControllerState.onPause;

    _eventController.add(ScenarioEventType.end);

    return Future.delayed(kDefaultAnimationDuration);
  }

  void done() {
    if (state == SlideControllerState.onPause) {
      _isDone = true;

      return;
    }

    state = SlideControllerState.onPause;

    if (_isDone) {
      return;
    }

    _isDone = true;
    _onDoneController.add(null);
  }

  void dispose() {
    state = SlideControllerState.onPause;

    _onDoneController.close();
    _eventController.close();
  }
}
