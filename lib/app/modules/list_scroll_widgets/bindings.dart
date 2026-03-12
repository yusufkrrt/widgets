import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class ListScrollWidgetsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListScrollWidgetsController>(ListScrollWidgetsController.new);
  }
}
