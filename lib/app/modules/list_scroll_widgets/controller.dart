import 'package:get/get.dart';

class ListScrollWidgetsController extends GetxController {
  final isLoading = false.obs;
  final selectedTab = 0.obs;

  final listItems = <String>[].obs;
  final gridItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;

      listItems.value = List.generate(
        20,
        (i) => 'Liste Öğesi ${i + 1}',
      );

      gridItems.value = List.generate(
        12,
        (i) => 'Galeri ${i + 1}',
      );
    } on Exception catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) => selectedTab.value = index;
}
