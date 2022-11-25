import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class InputDialog extends StatefulWidget {
  const InputDialog._({
    required this.title,
    required this.positiveButtonTitle,
    this.neutralButtonTitle,
    this.message,
    this.startValue,
    this.fallbackResult,
    this.onTyped,
  });

  final String title;
  final String positiveButtonTitle;
  final String? neutralButtonTitle;
  final String? message;
  final String? startValue;
  final String? fallbackResult;
  final ValueChanged<String>? onTyped;

  static Future<String?> show<TTheme>(
    BuildContext context, {
    required String title,
    String? message,
    required String positiveButtonTitle,
    String? neutralButtonTitle,
    String? fallbackResult,
    String? startValue,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (context) {
        return InputDialog._(
          title: title,
          message: message,
          positiveButtonTitle: positiveButtonTitle,
          neutralButtonTitle: neutralButtonTitle,
          fallbackResult: fallbackResult,
          startValue: startValue,
        );
      },
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? fallbackResult;
  }

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  bool _isOpened = false;

  late final _textController = TextEditingController()
    ..text = widget.startValue ?? ''
    ..addListener(_onTyped);

  late final _focusNode = FocusNode()..addListener(_onFocusChanged);

  void _onTyped() {
    widget.onTyped?.call(_textController.text);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus == _isOpened) {
      return;
    }

    setState(() {
      _isOpened = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final palette = theme.palette;
    final textStyles = theme.textStyles;

    return LeafyDialog(
      title: Text(widget.title),
      message: widget.message != null ? Text(widget.message!) : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 1.5,
        ),
        child: TextField(
          cursorColor: palette.leafyColor,
          scrollPadding: EdgeInsets.zero,
          minLines: 1,
          autofocus: true,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: '_Hint Text',
            hintStyle:
                textStyles.bodyText4.copyWith(color: palette.textInfoColor),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 7.5,
            ),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: palette.separatorColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: palette.separatorColor,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
          controller: _textController,
          keyboardType: TextInputType.text,
          onSubmitted: (val) {
            context.router.pop(val);
          },
          style: textStyles.bodyText4,
        ),
      ),
      options: [
        LeafyDialogOption<String?>.positive(
          title: widget.positiveButtonTitle,
          callback: () => _textController.text,
        ),
        LeafyDialogOption<String?>.neutral(
          title: widget.neutralButtonTitle ?? '_Cancel',
          callback: () => null,
        ),
      ],
    );
  }
}
