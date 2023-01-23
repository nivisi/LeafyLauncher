import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/header/widgets/home_clock.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/header/widgets/home_date.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/header/widgets/home_time_progress.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.homeWidgetsController.state.watch.isLoading;

    if (isLoading) {
      return const SizedBox();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHomeHorizontalPadding,
          vertical: kHomeVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                HomeClock(),
                Spacer(),
                HomeDate(),
              ],
            ),
            const LeafySpacer(multipler: 2),
            Builder(
              builder: (context) {
                final width = MediaQuery.of(context).size.width;
                return SizedBox(
                  width: width * .3,
                  child: const HomeTimeProgress(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
