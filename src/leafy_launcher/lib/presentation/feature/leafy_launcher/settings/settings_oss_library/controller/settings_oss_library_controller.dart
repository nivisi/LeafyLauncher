import 'package:controllable_flutter/controllable_flutter.dart';

part 'settings_oss_library_controller.x.dart';
part 'settings_oss_library_effect.dart';
part 'settings_oss_library_event.dart';
part 'settings_oss_library_state.dart';

@XControllable<SettingsOssLibraryEvent>()
class SettingsOssLibraryController extends XController<SettingsOssLibraryState>
    with _$SettingsOssLibraryController {
  @override
  SettingsOssLibraryState createInitialState() {
    return createSettingsOssLibraryState(
      counter: 0,
    );
  }
}
