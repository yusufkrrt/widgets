import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  DialogHelper._();

  static Future<void> showError(String message) async {
    await Get.dialog<void>(
      AlertDialog(
        title: const Text('Hata'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showConfirm({
    required String title,
    required String message,
  }) =>
      Get.dialog<bool>(
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back<bool>(result: false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () => Get.back<bool>(result: true),
              child: const Text('Evet'),
            ),
          ],
        ),
      );
}
