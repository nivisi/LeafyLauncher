import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafySectionChevronValue extends StatelessWidget {
  const LeafySectionChevronValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      LeafyIcons.chevronRight,
      color: context.leafyTheme.palette.textInfoColor,
      height: 12,
    );
  }
}
