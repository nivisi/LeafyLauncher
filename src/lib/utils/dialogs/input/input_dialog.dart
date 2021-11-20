import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/utils/dialogs/leafy_dialog.dart';

class InputDialog<TTheme extends LeafyTheme> extends StatefulWidget {
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

  static Future<String?> show<TTheme extends LeafyTheme>({
    required String title,
    String? message,
    required String positiveButtonTitle,
    String? neutralButtonTitle,
    String? fallbackResult,
    String? startValue,
    bool barrierDismissible = true,
  }) async {
    final result = await Get.dialog<String?>(
      InputDialog<TTheme>._(
        title: title,
        message: message,
        positiveButtonTitle: positiveButtonTitle,
        neutralButtonTitle: neutralButtonTitle,
        fallbackResult: fallbackResult,
        startValue: startValue,
      ),
      barrierColor: kBarrierColor,
      barrierDismissible: barrierDismissible,
    );

    return result ?? fallbackResult;
  }

  @override
  State<InputDialog<TTheme>> createState() => _InputDialogState<TTheme>();
}

class _InputDialogState<TTheme extends LeafyTheme>
    extends State<InputDialog<TTheme>> {
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
  Widget build(BuildContext context) {
    return LeafyDialog<TTheme>(
      title: Text(widget.title),
      message: widget.message != null ? Text(widget.message!) : null,
      body: LeafyThemeState<TTheme>(
        builder: (context, theme) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 1.5,
            ),
            child: TextField(
              cursorColor: theme.leafyColor,
              scrollPadding: EdgeInsets.zero,
              minLines: 1,
              autofocus: true,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: L10nProvider.getText(
                  L10n.leafyNotesFolderTitlePlaceholder,
                ),
                hintStyle: theme.bodyText4.copyWith(color: theme.textInfoColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 7.5,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.separatorColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.separatorColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              ),
              controller: _textController,
              keyboardType: TextInputType.text,
              onSubmitted: (val) {
                Get.back(result: val);
              },
              style: theme.bodyText4,
            ),
          );
        },
      ),
      options: [
        LeafyDialogOption<String?>.positive(
          title: widget.positiveButtonTitle,
          callback: () => _textController.text,
        ),
        LeafyDialogOption<String?>.neutral(
          title: widget.neutralButtonTitle ??
              L10nProvider.getText(L10n.actionCancel),
          callback: () => null,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
