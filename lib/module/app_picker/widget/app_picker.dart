import 'package:flutter/material.dart';

import '../../../resources/app_constants.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/application.dart';
import '../../../shared_widget/list/list_builder.dart';
import '../../../shared_widget/themed_widget.dart';

import 'app_picker_button.dart';

class AppPicker extends ThemedWidget<HomeTheme> {
  final String title;
  final FocusNode textFieldFocusNode;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final Iterable<Application> applications;
  final void Function(Application application) onAppSelected;
  final bool autofocusTextField;

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
          style: theme.bodyText1,
          autofocus: autofocusTextField,
          autocorrect: false,
        ),
        if (applications.isEmpty)
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding * 4.0),
            child: Text(
              'Nothing found 🔍',
              style: theme.bodyText1,
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
