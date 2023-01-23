import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

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

class LeafyDialogOptionWidget extends StatelessWidget {
  const LeafyDialogOptionWidget({super.key, required this.option});

  final LeafyDialogOption option;

  Color getForegroundColor(LeafyThemeData theme) {
    final palette = theme.palette;

    switch (option.type) {
      case LeafyDialogOptionType.positive:
        return palette.dialogPositiveColor;
      case LeafyDialogOptionType.neutral:
        return palette.foregroundColor;
      case LeafyDialogOptionType.negative:
        return palette.dialogNegativeColor;
      default:
        throw Exception('Unknown type');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: const ContinuousRectangleBorder(),
        // primary: theme.palette.foregroundColor.withOpacity(.2),
        fixedSize: const Size(100, 45),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => context.router.pop(option.callback()),
      child: Text(
        option.title,
        style: theme.textStyles.bodyText5
            .copyWith(color: getForegroundColor(theme)),
      ),
    );
  }
}

class LeafyDialog extends StatelessWidget {
  const LeafyDialog({
    Key? key,
    required this.title,
    this.message,
    this.body,
    required this.options,
  }) : super(key: key);

  final Widget title;
  final Widget? message;
  final Widget? body;

  final Iterable<LeafyDialogOption> options;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    final palette = theme.palette;
    final textStyles = theme.textStyles;

    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: palette.secondaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: kDefaultPadding * 1.5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TODO: Dismiss the keyboard here!
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultTextStyle(
                  style: textStyles.bodyText3
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  child: title is Text ? IgnorePointer(child: title) : title,
                ),
                if (message != null) const LeafySpacer(multipler: .5),
                if (message != null)
                  DefaultTextStyle(
                    style: textStyles.bodyText4,
                    textAlign: TextAlign.center,
                    child: message is Text
                        ? IgnorePointer(child: message)
                        : message!,
                  ),
                if (body != null) const LeafySpacer(multipler: 2.5),
                if (body != null) body!,
                const LeafySpacer(multipler: 2.0),
                Divider(
                  height: 1,
                  color: palette.backgroundColor,
                ),
                ...options.map(
                  (item) => LeafyDialogOptionWidget(option: item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
