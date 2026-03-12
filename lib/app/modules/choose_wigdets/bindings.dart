import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class ChooseWigdetsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseWigdetsController>(() => ChooseWigdetsController());
  }
}
