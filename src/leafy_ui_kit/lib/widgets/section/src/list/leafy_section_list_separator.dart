part of 'leafy_section_list.dart';

class _LeafySectionListSeparator extends StatelessWidget {
  const _LeafySectionListSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: kDefaultPadding * 2.0,
        bottom: kDefaultPadding * 2.0,
      ),
      child: LeafyDivider(),
    );
  }
}
