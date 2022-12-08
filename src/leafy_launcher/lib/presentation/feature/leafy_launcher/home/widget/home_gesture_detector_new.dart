import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/main/home_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/main/home_side_effect.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/drag_up/home_drag_up.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/horizontal_apps/home_horizontal_left_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/horizontal_apps/home_horizontal_right_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/pull_from_top/home_pull_from_top.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_launcher/presentation/services/ui/device_vibration_service_ui.dart';
import 'package:leafy_launcher/presentation/services/ui/home_button_listener_ui.dart';
import 'package:leafy_launcher/presentation/widgets/vibration/device_vibration.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

const _kCurve = Curves.fastOutSlowIn;
const _kDuration = Duration(milliseconds: 300);

class HomeGestureDetectorNew extends StatefulWidget {
  const HomeGestureDetectorNew({
    Key? key,
    required this.child,
    this.onLongPress,
    this.onDoubleTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  @override
  _HomeGestureDetectorNewState createState() => _HomeGestureDetectorNewState();
}

class _HomeGestureDetectorNewState extends State<HomeGestureDetectorNew>
    with TickerProviderStateMixin {
  static const swipeControllerThreshold = .97;
  static const gestureUpdateDivider = 150.0;
  static const _verticalIgnoringSpace = 70.0;
  static const _horizontalMinFlingVelocity = 1500.0;
  static const _verticalMinFlingVelocity = 1500.0;

  late final DeviceVibrationServiceUi _deviceVibration = injector();
  late final HomeButtonListenerUi _homeButtonListener = injector();
  late final LeafyPreferencesService _leafyPreferencesService = injector();

  late final StreamSubscription _onHomeButtonPressedSubscription;

  double _leftValue = 0.0;
  double _rightValue = 0.0;
  late final AnimationController _leftController;
  late final AnimationController _rightController;
  late final AnimationController _topController;
  late final AnimationController _bottomController;
  late final AnimationController _childController;

  static const curve = Curves.easeOut;

  void leftValueSetter(double val) {
    if (_leftValue == val) return;
    _leftValue = val;
    _leftController.value = curve.transform(val);
  }

  void rightValueSetter(double val) {
    if (_rightValue == val) return;
    _rightValue = val;
    _rightController.value = curve.transform(val);
  }

  double leftValueGetter() => _leftValue;
  double rightValueGetter() => _rightValue;

  late bool _canDragVertically;

  final ValueNotifier<bool> _isBottomListPresented = ValueNotifier<bool>(false);

  Future<LeafyPreferences> get preferences => _leafyPreferencesService.get();

  @override
  void initState() {
    super.initState();

    _onHomeButtonPressedSubscription = _homeButtonListener.addCallback(
      _hidePicker,
    );

    _leftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _leftController.value / 1.3;
      });

    _rightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _rightController.value / 1.3;
      });

    _topController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _topController.value / 1.3;
      });

    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _bottomController.value * 1.2;

        if (_bottomController.value >= .99) {
          if (_isBottomListPresented.value) {
            return;
          }

          _isBottomListPresented.value = true;
        } else {
          if (!_isBottomListPresented.value) {
            return;
          }

          setState(() {
            _isBottomListPresented.value = false;
          });
        }
      });

    _childController = AnimationController(
      vsync: this,
      value: 1.0,
    );
  }

  Future _hidePicker() {
    if (!_isBottomListPresented.value) {
      return Future.value();
    }

    return _bottomController.animateTo(
      0.0,
      duration: kDefaultAnimationDuration,
      curve: _kCurve,
    );
  }

  Future _onTopSwipe() async {
    // TODO: Show search
    return DeviceVibration.of(context).vibrateIfIsAlways();
  }

  void _onLeftSwipe() {
    DeviceVibration.of(context).vibrateIfIsAlways();

    final homeController = context.homeApplicationsController;
    final leftApp = homeController.state.leftApp;

    if (leftApp == null || leftApp is NoApplicationModel) {
      context.router.push(
        AppPickerRouteNew(
          autofocus: true,
          title: LeafyL10n.settingsToLeftApp,
          onAppSelected: (application) {
            homeController.raiseEvent.leftApplicationSelected(application);
            context.router.pop();
          },
        ),
      );
    } else {
      homeController.raiseEvent.launchLeftApplication(leftApp);
    }
  }

  void _onRightSwipe() {
    DeviceVibration.of(context).vibrateIfEnabled();

    final homeController = context.homeApplicationsController;
    final rightApp = homeController.state.rightApp;

    if (rightApp == null || rightApp is NoApplicationModel) {
      context.router.push(
        AppPickerRouteNew(
          title: LeafyL10n.settingsToRightApp,
          autofocus: true,
          onAppSelected: (application) {
            homeController.raiseEvent.rightApplicationSelected(application);
            context.router.pop();
          },
        ),
      );
    } else {
      homeController.raiseEvent.launchRightApplication(rightApp);
    }
  }

  Future _onBottomSwipe() async {
    _bottomController.animateTo(
      1.0,
      duration: _kDuration,
      curve: _kCurve,
    );

    DeviceVibration.of(context).vibrateIfIsAlways();
  }

  Future<void> _processChangesNew(
    AnimationController controller,
    AnimationController oppositeController,
    void Function(double val) setter,
    void Function(double val) oppositeSetter,
    double Function() getter,
    double Function() oppositeGetter,
    double change,
  ) async {
    final realChange = change / gestureUpdateDivider;

    if (oppositeGetter() > .0) {
      var val = oppositeGetter() - realChange;

      if (val <= .0) {
        val = .0;
      }

      if (val > 1) {
        val = 1;
      }

      oppositeSetter(val);

      return;
    }

    var val = getter() + realChange;

    if (val > 1.0) {
      val = 1.0;
    }

    if (val < 0.0) {
      val = 0.0;
    }

    if (val >= swipeControllerThreshold && getter() < .99) {
      DeviceVibration.of(context).vibrateIfIsAlways();
    }

    setter(val);
  }

  Future<void> _processChanges(
    AnimationController controller,
    AnimationController oppositeController,
    double change,
  ) async {
    final realChange = change / gestureUpdateDivider;

    if (oppositeController.value > .0) {
      var val = oppositeController.value - realChange;

      if (val <= .0) {
        val = .0;
      }

      oppositeController.value = val;

      return;
    }

    var val = controller.value + realChange;

    if (val >= 1.0) {
      val = 1.0;
    }

    if (val < 0.0) {
      val = 0.0;
    }

    if (val >= swipeControllerThreshold && controller.value < .99) {
      DeviceVibration.of(context).vibrateIfIsAlways();
    }

    controller.value = val;
  }

  Future<void> _onHorizontalUpdate(DragUpdateDetails details) async {
    final direction = details.delta.dx > .0 ? Direction.right : Direction.left;

    final controller = direction.isRight ? _rightController : _leftController;

    final oppositeController =
        direction.isRight ? _leftController : _rightController;

    final setter = direction.isRight ? rightValueSetter : leftValueSetter;

    final oppositeSetter =
        direction.isRight ? leftValueSetter : rightValueSetter;

    final getter = direction.isRight ? rightValueGetter : leftValueGetter;

    final oppositeGetter =
        direction.isRight ? leftValueGetter : rightValueGetter;

    final change = direction.isRight ? details.delta.dx : -details.delta.dx;

    _processChangesNew(
      controller,
      oppositeController,
      setter,
      oppositeSetter,
      getter,
      oppositeGetter,
      change,
    );
  }

  void _hideHorizontalIcons() {
    _leftValue = .0;
    _rightValue = .0;
    _leftController.animateTo(
      .0,
      duration: _kDuration,
      curve: _kCurve,
    );
    _rightController.animateTo(
      .0,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  void _hideVerticalIcons() {
    _topController.animateTo(
      .0,
      duration: _kDuration,
      curve: _kCurve,
    );
    _bottomController.animateTo(
      .0,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  Future<void> _onHorizontalDragEnd(DragEndDetails details) async {
    if (_leftController.value >= swipeControllerThreshold) {
      _onLeftSwipe();

      _hideHorizontalIcons();
      return;
    } else if (_rightController.value >= swipeControllerThreshold) {
      _onRightSwipe();

      _hideHorizontalIcons();

      return;
    }

    final visualVelocity = details.velocity.pixelsPerSecond.dx;

    if (visualVelocity.abs() > _horizontalMinFlingVelocity) {
      if (visualVelocity < 0.0) {
        _onLeftSwipe();
      } else {
        _onRightSwipe();
      }
    }

    _hideHorizontalIcons();
  }

  Future<void> _onVerticalUpdate(DragUpdateDetails details) async {
    if (!_canDragVertically) {
      return;
    }

    final direction = details.delta.dy > .0 ? Direction.down : Direction.up;

    final controller = direction.isDown ? _topController : _bottomController;

    final oppositeController =
        direction.isDown ? _bottomController : _topController;

    final change = direction.isDown ? details.delta.dy : -details.delta.dy;

    _processChanges(controller, oppositeController, change);
  }

  Future<void> _onVerticalDragEnd(DragEndDetails details) async {
    if (!_canDragVertically) {
      return;
    }

    if (_topController.value >= swipeControllerThreshold) {
      _onTopSwipe();

      _hideVerticalIcons();
      return;
    } else if (_bottomController.value >= swipeControllerThreshold) {
      _onBottomSwipe();

      _topController.animateTo(
        .0,
        duration: _kDuration,
        curve: _kCurve,
      );

      return;
    }

    final visualVelocity = details.velocity.pixelsPerSecond.dy;

    if (visualVelocity.abs() > _verticalMinFlingVelocity) {
      if (visualVelocity < 0.0) {
        _onBottomSwipe();

        _topController.animateTo(
          .0,
          duration: _kDuration,
          curve: _kCurve,
        );
      } else {
        _onTopSwipe();
        _hideVerticalIcons();
      }
    } else {
      _hideVerticalIcons();
    }
  }

  void _onVerticalStart(DragStartDetails details) {
    _canDragVertically = details.globalPosition.dy >= _verticalIgnoringSpace;
  }

  void _hidePickerOnBackButton() {
    if (_bottomController.value > .0) {
      _hidePicker();
    }
  }

  Future<void> _onLongPress() {
    return context.router.push(
      SettingsMainRoute(
        homeApplicationsController: context.read<HomeApplicationsController>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return XListener(
      streamable: context.homeController,
      listener: (context, event) {
        if (event == HomeSideEffect.backButtonPressed) {
          _hidePickerOnBackButton();
        }
      },
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragUpdate: _onHorizontalUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onVerticalDragStart: _onVerticalStart,
            onVerticalDragUpdate: _onVerticalUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            onLongPress: _onLongPress,
            // onDoubleTap: widget.onDoubleTap,
          ),
          FadeTransition(
            opacity: _childController,
            child: widget.child,
          ),
          HomeHorizontalLeftApp(controller: _leftController),
          HomeHorizontalRightApp(controller: _rightController),
          HomePullFromTop(controller: _topController),
          HomeDragUp(
            controller: _bottomController,
            isBottomListPresented: _isBottomListPresented,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _onHomeButtonPressedSubscription.cancel();

    _leftController.dispose();
    _rightController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    _childController.dispose();

    super.dispose();
  }
}
