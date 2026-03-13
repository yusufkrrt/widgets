import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class VisualInfoWidgetsBindings extends Bindings {
  @override
  void dependencies() {
    print("CALISMIYORUMMMM");
    Get.lazyPut<VisualInfoWidgetsController>(() => VisualInfoWidgetsController());
  }
}
