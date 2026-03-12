import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
