import 'package:get/get.dart';

class FatalErrorController extends GetxController {
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    errorMessage.value =
        Get.arguments as String? ?? 'Beklenmeyen bir hata oluştu.';
  }
}
