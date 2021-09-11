import 'application.dart';

class InstalledApplication extends Application {
  const InstalledApplication({
    required String name,
    required String package,
    required this.isSystem,
  }) : super(name: name, package: package);

  final bool isSystem;
}
