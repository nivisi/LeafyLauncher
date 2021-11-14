import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/utils/dialogs/leafy_dialog.dart';

class ActionsDialog<TTheme extends LeafyTheme, TResult>
    extends StatelessWidget {
  const ActionsDialog._({
    required this.title,
    this.message,
    required this.options,
    this.fallbackResult,
  });

  final String title;
  final String? message;
  final Iterable<LeafyDialogOption<TResult?>> options;
  final TResult? fallbackResult;

  static Future<TResult?> show<TTheme extends LeafyTheme, TResult>({
    required String title,
    String? message,
    required Iterable<LeafyDialogOption<TResult?>> options,
    TResult? fallbackResult,
    bool barrierDismissible = true,
  }) async {
    final result = await Get.dialog<TResult>(
      ActionsDialog<TTheme, TResult>._(
        title: title,
        message: message,
        options: options,
        fallbackResult: fallbackResult,
      ),
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? fallbackResult;
  }

  @override
  Widget build(BuildContext context) {
    return LeafyDialog<TTheme>(
      title: Text(title),
      message: message != null ? Text(message!) : null,
      options: options,
    );
  }
}
