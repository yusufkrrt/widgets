import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class PlaygroundBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaygroundController>(PlaygroundController.new);
  }
}
