import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_launcher/presentation/services/oss_licenses/oss_licenses_service.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsOssLibrariesBody extends StatelessWidget {
  const SettingsOssLibrariesBody(this.controller, {super.key});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final licenses = injector<OssLicensesService>().licenses;
    final theme = context.leafyTheme;

    return LeafySectionList(
      scrollController: controller,
      sections: [
        LeafySection(
          children: licenses.map((license) {
            return LeafySectionTextItem(
              title: license.name,
              onTap: () => context.router.push(
                SettingsOssLibraryRoute(license: license),
              ),
              value: Row(
                children: [
                  const LeafySpacer.horizontal(),
                  Text(
                    license.version,
                    style: theme.textStyles.bodyText5.copyWith(
                      color: theme.palette.textInfoColor,
                    ),
                  ),
                  const LeafySpacer.horizontal(),
                  const LeafySectionChevronValue(),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
