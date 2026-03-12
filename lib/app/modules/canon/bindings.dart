import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class CanonBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CanonController>(CanonController.new);
  }
}
