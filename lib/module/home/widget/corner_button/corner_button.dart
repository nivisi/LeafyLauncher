import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/app_constants.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/leafy_text_button.dart';
import '../../../../shared_widget/themed_widget.dart';
import '../../home_controller.dart';

enum CornerButtonType {
  phone,
  messages,
  camera,
}

enum CornerButtonPosition {
  left,
  right,
}

class CornerButton extends ThemedWidget<HomeTheme> {
  static const _size = 48.0;
  static const _iconSize = 24.0;

  final CornerButtonType _type;
  final CornerButtonPosition _position;

  const CornerButton({
    Key? key,
    required CornerButtonType type,
    required CornerButtonPosition position,
  })  : _type = type,
        _position = position,
        super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final alignment = _position == CornerButtonPosition.left
        ? Alignment.bottomLeft
        : Alignment.bottomRight;

    final IconData icon;

    switch (_type) {
      case CornerButtonType.phone:
        icon = Icons.phone;
        break;
      case CornerButtonType.messages:
        icon = Icons.message;
        break;
      case CornerButtonType.camera:
        icon = Icons.camera_alt;

        break;
      default:
        throw Exception('Unknown CornerButtonType');
    }

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(kDefaultPadding),
        width: _size,
        height: _size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: LeafyTextButton<HomeTheme>(
          onPressed: () => Get.find<HomeController>().cornerButtonPressed(
            _type,
          ),
          child: Icon(
            icon,
            size: _iconSize,
          ),
        ),
      ),
    );
  }
}
