import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import '../../../../resources/app_constants.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../services/device_vibration/device_vibration.dart';
import '../../../../shared_widget/leafy_text_button.dart';
import '../../../../shared_widget/themed_state.dart';
import '../../../../shared_widget/themed_widget.dart';
import '../../../../utils/enum/corner_button_type.dart';
import '../../home_controller.dart';

part '_configured_icon_button.dart';
part '_full_screen_box.dart';
part '_other_apps_list.dart';

enum CornerButtonPosition {
  left,
  right,
}

class CornerButton extends StatefulWidget {
  CornerButton({
    Key? key,
    required this.type,
    required this.position,
  })  : otherTypes = CornerButtonType.values.toList()..remove(type),
        super(key: key);

  final CornerButtonType type;
  final CornerButtonPosition position;

  final Iterable<CornerButtonType> otherTypes;

  @override
  _CornerButtonState createState() => _CornerButtonState();
}

class _CornerButtonState extends ThemedState<CornerButton, HomeTheme>
    with TickerProviderStateMixin {
  late final HomeController _homeController;
  late final DeviceVibration _deviceVibration;

  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();

    _homeController = Get.find<HomeController>();
    _deviceVibration = Get.find<DeviceVibration>();
  }

  void _startSelecting() {
    if (!_isSelecting) {
      setState(() {
        _isSelecting = true;
      });
    }
  }

  void _stopSelecting() {
    if (_isSelecting) {
      setState(() {
        _isSelecting = false;
      });
    }
  }

  @override
  Widget body(BuildContext context, HomeTheme theme) {
    final alignment = widget.position == CornerButtonPosition.left
        ? Alignment.bottomLeft
        : Alignment.bottomRight;

    return Stack(
      children: [
        if (_isSelecting)
          GestureDetector(
            onPanDown: (_) {
              _stopSelecting();
            },
            child: const _FullScreenBox(),
          ),
        IgnorePointer(
          ignoring: !_isSelecting,
          child: AnimatedOpacity(
            opacity: _isSelecting ? 1.0 : .0,
            duration: kDefaultAnimationDuration,
            child: Align(
              alignment: alignment,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  widget.position == CornerButtonPosition.left
                      ? kDefaultPadding * 1.3
                      : 0.0,
                  .0,
                  widget.position == CornerButtonPosition.right
                      ? kDefaultPadding * 1.3
                      : .0,
                  kDefaultPadding * 6.0,
                ),
                child: _OtherAppsList(
                  types: widget.otherTypes,
                  onPressed: (type) {
                    _homeController.setButton(widget.position, type);

                    _stopSelecting();
                  },
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: alignment,
          child: _ConfiguredIconButton(
            margin: kHomeCornerButtonEdgeInsets,
            type: widget.type,
            onPressed: () {
              if (!LeafySettings.vibrateNever) {
                _deviceVibration.weak();
              }

              _homeController.cornerButtonPressed(
                widget.type,
              );
            },
            onLongPressed: _startSelecting,
          ),
        ),
      ],
    );
  }
}
