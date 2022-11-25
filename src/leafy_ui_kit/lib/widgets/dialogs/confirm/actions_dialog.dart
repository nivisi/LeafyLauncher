import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class ActionsDialog<TResult> extends StatelessWidget {
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

  static Future<TResult?> show<TResult>(
    BuildContext context, {
    required String title,
    String? message,
    required Iterable<LeafyDialogOption<TResult?>> options,
    TResult? fallbackResult,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<TResult>(
      context: context,
      builder: (context) {
        return ActionsDialog<TResult>._(
          title: title,
          message: message,
          options: options,
          fallbackResult: fallbackResult,
        );
      },
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? fallbackResult;
  }

  @override
  Widget build(BuildContext context) {
    return LeafyDialog(
      title: Text(title),
      message: message != null ? Text(message!) : null,
      options: options,
    );
  }
}
