import 'package:get/get.dart';

class GraphsStaticsController extends GetxController {
  final isLoading = false.obs;

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
