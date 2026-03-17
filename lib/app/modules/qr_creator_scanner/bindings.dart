import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class QrCreatorScannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCreatorScannerController>(QrCreatorScannerController.new);
  }
}
