import 'package:ogrenme/app/modules/modules.dart';
import 'package:get/get.dart';

class DatepickerCalendarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatepickerCalendarController>(DatepickerCalendarController.new);
  }
}
