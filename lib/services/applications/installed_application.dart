import 'application.dart';

class InstalledApplication extends Application {
  const InstalledApplication({
    required String name,
    required String package,
  }) : super(name: name, package: package);

  Future launch() async {}
}
