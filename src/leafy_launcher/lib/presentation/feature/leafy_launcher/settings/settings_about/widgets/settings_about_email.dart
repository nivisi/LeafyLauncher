import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/configs/contact_links_config.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsAboutEmail extends StatelessWidget {
  const SettingsAboutEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeafySectionTextItem(
      title: LeafyL10n.settingsAboutOpenGmail,
      leading: SvgPicture.asset(
        LeafyIcons.gmail,
        color: context.leafyTheme.palette.foregroundColor,
      ),
      onTap: () => launch(injector<ContactLinksConfig>().email)
          .onError((error, stackTrace) => false),
    );
  }
}
