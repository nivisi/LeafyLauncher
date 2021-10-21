import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_notes/home_notes_controller.dart';

class HomeNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeNotesController());
  }
}
