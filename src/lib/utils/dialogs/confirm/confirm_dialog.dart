import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/utils/dialogs/leafy_dialog.dart';

class ConfirmDialog<TTheme extends LeafyTheme> extends StatelessWidget {
  const ConfirmDialog._({
    required this.title,
    required this.message,
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    this.isConfirmActionDestructive = false,
  });

  final String title;
  final String message;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final bool isConfirmActionDestructive;

  static Future<bool> show<TTheme extends LeafyTheme>({
    required String title,
    required String message,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool barrierDismissible = false,
    bool isConfirmActionDestructive = false,
  }) async {
    final result = await Get.dialog<bool>(
      ConfirmDialog<TTheme>._(
        title: title,
        message: message,
        confirmButtonTitle: confirmButtonTitle,
        cancelButtonTitle: cancelButtonTitle,
        isConfirmActionDestructive: isConfirmActionDestructive,
      ),
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return LeafyDialog<TTheme>(
      title: Text(title),
      message: Text(message),
      options: [
        LeafyDialogOption<bool>(
          title: confirmButtonTitle,
          callback: () {
            return true;
          },
          type: isConfirmActionDestructive
              ? LeafyDialogOptionType.negative
              : LeafyDialogOptionType.positive,
        ),
        LeafyDialogOption<bool>(
          title: cancelButtonTitle,
          callback: () {
            return false;
          },
          type: LeafyDialogOptionType.neutral,
        ),
      ],
    );
  }
}
