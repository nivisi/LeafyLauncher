import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  const ToastService();

  Future<void> short(String text, {bool cancelPrevious = false}) async {
    if (cancelPrevious) {
      await Fluttertoast.cancel();
    }

    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  Future<void> long(String text, {bool cancelPrevious = false}) async {
    if (cancelPrevious) {
      await Fluttertoast.cancel();
    }

    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
