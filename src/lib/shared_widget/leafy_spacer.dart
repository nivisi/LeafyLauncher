import 'package:flutter/material.dart';

import '../resources/app_constants.dart';

enum LeafySpacerType {
  horizontal,
  vertical,
}

class LeafySpacer extends StatelessWidget {
  const LeafySpacer({
    Key? key,
    this.multipler = 1.0,
    this.type = LeafySpacerType.vertical,
  }) : super(key: key);

  final double multipler;
  final LeafySpacerType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LeafySpacerType.vertical:
        return SizedBox(height: kDefaultPadding * multipler);
      case LeafySpacerType.horizontal:
        return SizedBox(width: kDefaultPadding * multipler);
      default:
        throw 'Unknown type';
    }
  }
}
