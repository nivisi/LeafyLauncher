import 'package:share/share.dart';

class ShareService {
  Future<void> shareText(String text, {String? subject}) {
    return Share.share(text, subject: subject);
  }
}
