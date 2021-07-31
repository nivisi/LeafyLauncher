import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

enum LeafyDialogOptionType {
  positive,
  neutral,
  negative,
}

class LeafyDialogOption<T> {
  const LeafyDialogOption({
    required this.title,
    required this.callback,
    required this.type,
  });

  const LeafyDialogOption.positive({
    required this.title,
    required this.callback,
  }) : type = LeafyDialogOptionType.positive;

  const LeafyDialogOption.neutral({
    required this.title,
    required this.callback,
  }) : type = LeafyDialogOptionType.neutral;

  const LeafyDialogOption.negative({
    required this.title,
    required this.callback,
  }) : type = LeafyDialogOptionType.negative;

  final String title;
  final T Function() callback;
  final LeafyDialogOptionType type;
}

class _LeafyDialogOptionWidget<T extends LeafyTheme> extends ThemedWidget<T> {
  const _LeafyDialogOptionWidget({Key? key, required this.option})
      : super(key: key);

  final LeafyDialogOption option;

  Color getForegroundColor(LeafyTheme theme) {
    switch (option.type) {
      case LeafyDialogOptionType.positive:
        return theme.dialogPositiveColor;
      case LeafyDialogOptionType.neutral:
        return theme.foregroundColor;
      case LeafyDialogOptionType.negative:
        return theme.dialogNegativeColor;
      default:
        throw Exception('Unknown type');
    }
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: const ContinuousRectangleBorder(),
        primary: theme.foregroundColor.withOpacity(.2),
        fixedSize: const Size(100, 45),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => Get.back(result: option.callback()),
      child: Text(
        option.title,
        style: theme.bodyText4.copyWith(color: getForegroundColor(theme)),
      ),
    );
  }
}

class LeafyDialog<TTheme extends LeafyTheme> extends StatelessWidget {
  const LeafyDialog({
    Key? key,
    required this.title,
    this.message,
    required this.options,
  }) : super(key: key);

  final String title;
  final String? message;

  final Iterable<LeafyDialogOption> options;

  @override
  Widget build(BuildContext context) {
    return LeafyThemeState<TTheme>(
      builder: (context, theme) {
        return Dialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: theme.secondaryBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding * 1.5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: theme.bodyText3,
                  textAlign: TextAlign.center,
                ),
                if (message != null) const LeafySpacer(multipler: 1.5),
                if (message != null)
                  Text(
                    message!,
                    style: theme.bodyText4,
                    textAlign: TextAlign.center,
                  ),
                const LeafySpacer(multipler: 2),
                Divider(
                  height: 1,
                  color: theme.backgroundColor,
                ),
                ...options.map(
                  (item) => _LeafyDialogOptionWidget<TTheme>(option: item),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
