import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class AnimationsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimationsController>(AnimationsController.new);
  }
}
