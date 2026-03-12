import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(DashboardController.new);
  }
}
