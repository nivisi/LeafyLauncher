import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

class LeafyLocalizedApp extends StatelessWidget {
  const LeafyLocalizedApp({
    super.key,
    required this.child,
    this.initialLocale,
  });

  final Widget child;
  final Locale? initialLocale;

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: initialLocale,
      child: child,
    );
  }

  static void setLocale(BuildContext context, Locale locale) {
    I18n.of(context).locale = locale;
  }
}
