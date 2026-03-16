import 'package:get/get.dart';

class AppController extends GetxController {
  // simple app-level controller placeholder
  final title = 'ogrenme'.obs;

  void setTitle(String value) => title.value = value;
}
