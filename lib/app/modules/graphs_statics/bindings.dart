import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class GraphsStaticsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GraphsStaticsController>(GraphsStaticsController.new);
  }
}
