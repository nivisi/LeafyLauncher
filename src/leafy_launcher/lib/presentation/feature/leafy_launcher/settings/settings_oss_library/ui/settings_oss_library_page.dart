import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leafy_launcher/presentation/extensions/scroll_controller_extensions.dart';
import 'package:leafy_launcher/presentation/services/oss_licenses/oss_license.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsOssLibraryPage extends StatefulWidget {
  const SettingsOssLibraryPage({
    super.key,
    required this.license,
  });

  final OssLicense license;

  @override
  State<SettingsOssLibraryPage> createState() => _SettingsOssLibraryPageState();
}

class _SettingsOssLibraryPageState extends State<SettingsOssLibraryPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.leafyTheme.palette;

    return LeafyScaffold(
      title: '${widget.license.name} ${widget.license.version}',
      onTitleTap: controller.scrollPageToTop,
      child: LeafySectionList(
        scrollController: controller,
        sections: [
          LeafySection(
            header: LeafyL10n.settingsAboutOssLicenseDescriptionHeader,
            footer: widget.license.description,
            children: const [],
          ),
          if (widget.license.homepage != null)
            LeafySection(
              header: LeafyL10n.settingsAboutOssLicenseHomepageHeader,
              children: [
                LeafySectionTextItem(
                  title: LeafyL10n.settingsAboutOssOpenWebsite,
                  leading: SvgPicture.asset(
                    LeafyIcons.web,
                    color: palette.foregroundColor,
                  ),
                  onTap: () {
                    launch(widget.license.homepage!).catchError((e, s) {});
                  },
                )
              ],
            ),
          LeafySection(
            header: LeafyL10n.settingsAboutOssLicenseLicenseHeader,
            footer: widget.license.license,
            children: const [],
          ),
        ],
      ),
    );
  }
}
