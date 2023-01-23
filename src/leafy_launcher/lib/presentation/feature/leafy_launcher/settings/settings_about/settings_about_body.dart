import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/settings_about_inherited.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/widgets/settings_about_email.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/widgets/settings_about_github.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/widgets/settings_about_telegram.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsAboutBody extends StatelessWidget {
  const SettingsAboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LeafySectionList(
      scrollController: SettingsAboutInherited.of(context).scrollController,
      sections: [
        LeafySection(
          footer: LeafyL10n.settingsAboutInfo,
          children: const [
            SettingsAboutGithub(),
            SettingsAboutEmail(),
            SettingsAboutTelegram(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsAboutOssHeader,
          footer: LeafyL10n.settingsAboutOssFooter,
          children: [
            LeafySectionTextItem(
              title: LeafyL10n.settingsAboutOss,
              onTap: () => context.router.navigate(
                const SettingsOssLibrariesRoute(),
              ),
              value: const LeafySectionChevronValue(),
            ),
          ],
        ),
      ],
    );
  }
}
