import 'package:flutter/material.dart';

import '../../../../resources/app_constants.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/list/list_builder.dart';
import '../../../../shared_widget/themed_widget.dart';

class GoogleSearchResults extends ThemedWidget<HomeTheme> {
  const GoogleSearchResults({
    Key? key,
    required this.results,
    required this.onSuggestionPicked,
  }) : super(key: key);

  final Iterable<String> results;
  final void Function(String) onSuggestionPicked;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text(
          'Nothing Found!',
          style: TextStyle(color: theme.foregroundColor),
        ),
      );
    }

    return ListBuilder<String>(
      builder: (item) {
        return TextButton(
          onPressed: () {
            onSuggestionPicked(item);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item,
              style: TextStyle(
                color: theme.foregroundColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        );
      },
      items: results,
    );
  }
}
