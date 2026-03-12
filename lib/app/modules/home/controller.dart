import 'package:get/get.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final username = 'Kullanıcı'.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;
      // TODO: Fetch user info and home screen data
      await Future<void>.delayed(const Duration(milliseconds: 300));
    } on Exception catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() => _load();
}
