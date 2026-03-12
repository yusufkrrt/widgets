import 'package:get/get.dart';
import 'text_controller.dart';

class TextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextController>(() => TextController());
  }
}
