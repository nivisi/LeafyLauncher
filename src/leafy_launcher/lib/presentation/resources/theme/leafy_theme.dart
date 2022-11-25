// import 'package:flutter/material.dart';
// import 'package:leafy_launcher/presentation/resources/theme/home/leafy_home_theme_data_bright.dart';
// import 'package:leafy_launcher/presentation/resources/theme/home/leafy_home_theme_data_dark.dart';
// import 'package:leafy_launcher/presentation/resources/theme/leafy_theme_data.dart';

// export 'leafy_theme_data.dart';

// class _LeafyThemeInherited extends InheritedWidget {
//   const _LeafyThemeInherited({
//     Key? key,
//     required Widget child,
//     required this.themeData,
//   }) : super(key: key, child: child);

//   final LeafyThemeData themeData;

//   @override
//   bool updateShouldNotify(covariant _LeafyThemeInherited oldWidget) {
//     return themeData != oldWidget.themeData;
//   }
// }

// class LeafyThemeNew extends StatefulWidget {
//   const LeafyThemeNew({
//     Key? key,
//     required this.themeData,
//     required this.child,
//   }) : super(key: key);

//   const LeafyThemeNew.defaultDark({
//     Key? key,
//     required this.child,
//   })  : themeData = homeThemeDark,
//         super(key: key);

//   const LeafyThemeNew.defaultBright({
//     Key? key,
//     required this.child,
//   })  : themeData = homeThemeBright,
//         super(key: key);

//   final LeafyThemeData themeData;
//   final Widget child;

//   @override
//   State<LeafyThemeNew> createState() => _LeafyThemeNewState();

//   static LeafyThemeData of(BuildContext context) {
//     final data = context
//         .dependOnInheritedWidgetOfExactType<_LeafyThemeInherited>()
//         ?.themeData;

//     assert(data != null);

//     return data!;
//   }
// }

// class _LeafyThemeNewState extends State<LeafyThemeNew> {
//   @override
//   Widget build(BuildContext context) {
//     return _LeafyThemeInherited(
//       themeData: widget.themeData,
//       child: widget.child,
//     );
//   }
// }

// extension LeafyThemeBuildContext on BuildContext {
//   LeafyThemeData get leafyTheme {
//     return LeafyThemeNew.of(this);
//   }
// }
