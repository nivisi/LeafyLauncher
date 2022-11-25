import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import 'app_picker_button.dart';
import 'app_picker_fade.dart';

class AppPicker extends StatelessWidget {
  const AppPicker({
    Key? key,
    required this.title,
    required this.textFieldFocusNode,
    required this.textEditingController,
    required this.scrollController,
    required this.applications,
    required this.onAppSelected,
    required this.autofocusTextField,
    this.onLongPress,
    this.slidesScrollController,
  }) : super(key: key);

  final String title;
  final FocusNode textFieldFocusNode;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final Iterable<ApplicationModelBase> applications;
  final ValueChanged<ApplicationModelBase> onAppSelected;
  final ValueChanged<ApplicationModelBase>? onLongPress;
  final bool autofocusTextField;
  final ScrollController? slidesScrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    final palette = theme.palette;
    final textStyles = theme.textStyles;

    return Column(
      children: [
        const LeafySpacer(multipler: 2.0),
        Text(
          title,
          // style: theme.bodyText2,
        ),
        TextField(
          focusNode: textFieldFocusNode,
          controller: textEditingController,
          style: textStyles.bodyText1.copyWith(color: palette.leafyColor),
          autofocus: autofocusTextField,
          autocorrect: false,
          textAlign: TextAlign.center,
          cursorColor: palette.leafyColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: textStyles.bodyText2.copyWith(
              color: palette.textInfoColor,
            ),
          ),
        ),
        Expanded(
          child: applications.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding * 2.0,
                    horizontal: kHomeHorizontalPadding,
                  ),
                  child: Text(
                    'Nothing found',
                    style: textStyles.bodyText2,
                  ),
                )
              : AppPickerFade(
                  child: ListView.separated(
                    controller: slidesScrollController ?? scrollController,
                    padding: const EdgeInsets.fromLTRB(
                      kHomeHorizontalPadding,
                      kDefaultPadding * 2.0,
                      kHomeHorizontalPadding,
                      kDefaultPadding * 2.0,
                    ),
                    itemCount: applications.length,
                    separatorBuilder: (_, __) => const LeafySpacer(),
                    itemBuilder: (context, index) {
                      final app = applications.elementAt(index);
                      return AppPickerButton(
                        application: app,
                        onTapped: onAppSelected,
                        onLongPress: onLongPress,
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
