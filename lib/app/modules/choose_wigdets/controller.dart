import 'package:get/get.dart';

class ChooseWigdetsController extends GetxController {
  final isLoading = false.obs;
  final isChecked = false.obs;
  final selectedRadio = 1.obs;
  final isSwitched = false.obs;
  final sliderValue = 50.0.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;
      // TODO: load data
    } on Exception catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }
}
