part of 'leafy_section_list.dart';

class _LeafySectionListSeparator<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const _LeafySectionListSeparator({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding * 2.0,
        bottom: kDefaultPadding * 2.0,
      ),
      child: Divider(
        height: 1.0,
        color: theme.separatorColor,
      ),
    );
  }
}
