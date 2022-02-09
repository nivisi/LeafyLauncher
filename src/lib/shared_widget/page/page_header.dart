import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';

import '../themed_widget.dart';

class PageHeader extends ThemedWidget<HomeTheme> {
  const PageHeader({
    Key? key,
    required this.title,
    this.hasBackButton = true,
    this.onTapped,
    this.largerTitle = false,
  })  : titleBuilder = null,
        super(key: key);

  const PageHeader.builder({
    Key? key,
    required this.titleBuilder,
    this.hasBackButton = true,
    this.onTapped,
    this.largerTitle = false,
  })  : title = null,
        super(key: key);

  final String? title;
  final Widget Function(BuildContext context, TextStyle textStyle)?
      titleBuilder;
  final VoidCallback? onTapped;
  final bool hasBackButton;
  final bool largerTitle;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    late final Widget titleWidget;

    final textStyle = (largerTitle ? theme.bodyText1 : theme.bodyText3)
        .copyWith(fontWeight: FontWeight.w500);

    if (title != null) {
      titleWidget = Expanded(child: Text(title!, style: textStyle));
    } else {
      titleWidget = titleBuilder!(context, textStyle);
    }

    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: theme.separatorColor)),
        ),
        padding: EdgeInsets.fromLTRB(
          hasBackButton ? kDefaultPadding / 2.0 : kDefaultPadding,
          kDefaultPadding * 1.5,
          kDefaultPadding,
          kDefaultPadding * 1.5,
        ),
        child: Row(
          children: [
            if (hasBackButton)
              LeafyTextButton<HomeTheme>.circled(
                onPressed: Get.back,
                size: 40.0,
                child: Icon(
                  Icons.chevron_left,
                  color: theme.foregroundColor,
                  size: 32,
                ),
              ),
            if (hasBackButton) const LeafySpacer.horizontal(multipler: .5),
            titleWidget,
          ],
        ),
      ),
    );
  }
}
