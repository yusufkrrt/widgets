import 'package:get/get.dart';
import 'controller.dart';

class MapWebviewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapWebviewController>(MapWebviewController.new);
  }
}
