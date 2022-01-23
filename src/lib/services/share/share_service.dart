import 'dart:io';

import 'package:share/share.dart';

class ShareService {
  Future<void> shareText(String text, {String? subject}) {
    return Share.share(text, subject: subject);
  }

  Future<void> shareFile(File file, {String? subject}) {
    return Share.shareFiles([file.path], subject: subject);
  }
}
