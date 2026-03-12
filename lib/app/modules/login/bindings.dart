import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(LoginController.new);
  }
}
