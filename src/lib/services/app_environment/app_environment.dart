import 'package:leafy_launcher/utils/app_flavour/app_flavour.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppEnvironment {
  AppEnvironment(this._flavour);

  final AppFlavour _flavour;

  late final String _version;
  late final String _build;
  late final String _name;
  late final String _package;

  AppFlavour get flavour => _flavour;
  bool get isDev => _flavour == AppFlavour.dev;
  bool get isProd => _flavour == AppFlavour.prod;

  String get version => _version;
  String get build => _build;
  String get name => _name;
  String get package => _package;

  String get github => 'https://github.com/nivisi/LeafyLauncher';
  String get email => 'leafylauncher@gmail.com';
  String get telegramChat => 'https://t.me/+MJJJZbkBNpdhMzdi';

  Future<AppEnvironment> init() async {
    final packageInfo = await PackageInfo.fromPlatform();

    _name = packageInfo.appName;
    _package = packageInfo.packageName;
    _version = packageInfo.version;
    _build = packageInfo.buildNumber;

    return this;
  }
}
