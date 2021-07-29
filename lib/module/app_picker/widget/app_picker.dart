import 'package:flutter/material.dart';

import '../../../resources/app_constants.dart';
import '../../../resources/localization/l10n.dart';
import '../../../resources/localization/l10n_provider.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/application.dart';
import '../../../shared_widget/list/list_builder.dart';
import '../../../shared_widget/themed_widget.dart';
import 'app_picker_button.dart';

class AppPicker extends ThemedWidget<HomeTheme> {
  const AppPicker({
    Key? key,
    required this.title,
    required this.textFieldFocusNode,
    required this.textEditingController,
    required this.scrollController,
    required this.applications,
    required this.onAppSelected,
    required this.autofocusTextField,
  }) : super(key: key);

  final String title;
  final FocusNode textFieldFocusNode;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final Iterable<Application> applications;
  final void Function(Application application) onAppSelected;
  final bool autofocusTextField;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      children: [
        Text(
          title,
          style: theme.bodyText1,
        ),
        TextField(
          focusNode: textFieldFocusNode,
          controller: textEditingController,
          style: theme.bodyText2,
          autofocus: autofocusTextField,
          autocorrect: false,
          textAlign: TextAlign.center,
          cursorColor: theme.leafyColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: theme.bodyText2.copyWith(
              color: theme.textInfoColor,
            ),
          ),
        ),
        if (applications.isEmpty)
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 4.0),
            child: Text(
              L10nProvider.getText(L10n.appPickerNothingFound),
              style: theme.bodyText2,
            ),
          )
        else
          Expanded(
            child: ListBuilder<Application>(
              scrollController: scrollController,
              padding: const EdgeInsets.all(kDefaultPadding * 2.0),
              items: applications,
              separatorType: SeparatorType.space,
              builder: (app) {
                return AppPickerButton(
                  application: app,
                  onTapped: onAppSelected,
                );
              },
            ),
          )
      ],
    );
  }
}
