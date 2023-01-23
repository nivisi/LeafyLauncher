import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class ConfirmDialog extends StatelessWidget {
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

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    bool barrierDismissible = false,
    bool isConfirmActionDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return ConfirmDialog._(
          title: title,
          message: message,
          confirmButtonTitle: confirmButtonTitle,
          cancelButtonTitle: cancelButtonTitle,
          isConfirmActionDestructive: isConfirmActionDestructive,
        );
      },
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return LeafyDialog(
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
