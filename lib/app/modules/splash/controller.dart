import 'package:ogrenme/app/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    await Get.offAllNamed<void>(AppPaths.login);
  }
}
