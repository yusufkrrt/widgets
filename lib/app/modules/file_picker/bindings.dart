import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class FilePickerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilePickerController>(FilePickerController.new);
  }
}
