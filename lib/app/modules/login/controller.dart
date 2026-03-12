import 'package:ogrenme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    try {
      isLoading.value = true;
      // TODO: implement login logic
      await Get.offAllNamed<void>(AppPaths.home);
    } on Exception catch (e) {
      Get.snackbar('Hata', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
