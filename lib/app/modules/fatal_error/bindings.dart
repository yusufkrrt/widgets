import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class FatalErrorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FatalErrorController>(FatalErrorController.new);
  }
}
