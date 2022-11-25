import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

@lazySingleton
class UrlLauncher {
  Future<bool> launch(String url) {
    return url_launcher.launch(url);
  }
}
