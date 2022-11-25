import 'package:flutter/widgets.dart';
  
import '../controller/settings_oss_library_controller.dart';  

class SettingsOssLibraryBody extends StatelessWidget {
  const SettingsOssLibraryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsOssLibraryController;

    return Text(controller.state.watch.counter.toString());
  }
}
