import 'package:get/get.dart';
import 'textfield_controller.dart';

class TextFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextFieldController>(() => TextFieldController());
  }
}
