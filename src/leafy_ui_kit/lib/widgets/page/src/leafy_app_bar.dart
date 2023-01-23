import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';
import 'package:leafy_ui_kit/widgets/buttons/src/leafy_text_button.dart';
import 'package:leafy_ui_kit/widgets/misc/src/leafy_spacer.dart';

const kLeafyAppBarHeight = 64.0;

class LeafyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LeafyAppBar({
    Key? key,
    required this.title,
    this.forceHideBackButton = false,
    this.onTapped,
    this.bigTitle = false,
  })  : titleBuilder = null,
        super(key: key);

  const LeafyAppBar.builder({
    Key? key,
    required this.titleBuilder,
    this.forceHideBackButton = false,
    this.onTapped,
    this.bigTitle = false,
  })  : title = null,
        super(key: key);

  final String? title;
  final Widget Function(BuildContext context, TextStyle textStyle)?
      titleBuilder;
  final VoidCallback? onTapped;
  final bool forceHideBackButton;
  final bool bigTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kLeafyAppBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final textStyles = theme.textStyles;
    final palette = theme.palette;

    late final Widget titleWidget;

    final textStyle = (bigTitle ? textStyles.bodyText1 : textStyles.bodyText3)
        .copyWith(fontWeight: FontWeight.w500);

    if (title != null) {
      titleWidget = Expanded(child: Text(title!, style: textStyle));
    } else {
      titleWidget = titleBuilder!(context, textStyle);
    }

    final canShowBackButton = !forceHideBackButton && context.router.canPop();

    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: palette.separatorColor)),
        ),
        padding: EdgeInsets.fromLTRB(
          !forceHideBackButton ? kDefaultPadding / 2.0 : kDefaultPadding,
          kDefaultPadding * 1,
          kDefaultPadding,
          kDefaultPadding * 1,
        ),
        child: Row(
          children: [
            if (canShowBackButton)
              LeafyTextButton.circled(
                onPressed: context.router.pop,
                child: Icon(
                  Icons.chevron_left,
                  color: palette.foregroundColor,
                  size: 32,
                ),
              ),
            if (canShowBackButton) const LeafySpacer.horizontal(multipler: .5),
            titleWidget,
          ],
        ),
      ),
    );
  }
}
