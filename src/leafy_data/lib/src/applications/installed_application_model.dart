import 'package:leafy_data/src/applications/application_base_model.dart';

/// An application installed on the device.
class InstalledApplicationModel extends ApplicationModelBase {
  const InstalledApplicationModel({
    required String name,
    required this.packageName,
    required this.isSystem,
  }) : super(name);

  final String packageName;
  final bool isSystem;
}
