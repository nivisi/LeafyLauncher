import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/configs/contact_links_config.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsAboutGithub extends StatelessWidget {
  const SettingsAboutGithub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeafySectionTextItem(
      title: LeafyL10n.settingsAboutOpenGithub,
      leading: SvgPicture.asset(
        LeafyIcons.github,
        color: context.leafyTheme.palette.foregroundColor,
      ),
      onTap: () => launch(injector<ContactLinksConfig>().github)
          .onError((error, stackTrace) => false),
    );
  }
}
