import 'dart:ui';

import 'package:get/get.dart';

class AnimationsController extends GetxController {
  final isLoading = false.obs;

  // 1. Implicit Animation (Otomatik Animasyon) için  var isExpanded = false.obs;

  // 2. Fade/Opacity için
  var isVisible = true.obs;
  // 3. List Animasyonu için
  var items = <String>[].obs;

  var isExpanded=false.obs;
  final RxBool animationToggle = false.obs;

  var ballPosition = const Offset(100, 100).obs; // Başlangıç konumu

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void toggleBox() => isExpanded.toggle();
  void toggleAnimation() => animationToggle.toggle();
  void toggleVisibility() => isVisible.toggle();

  void addItem() {
    items.add("Yeni Eleman ${items.length + 1}");
  }

  Future<void> _load() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;
  }
}
