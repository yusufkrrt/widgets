import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends GetView<LoginController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () => SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed:
                controller.isLoading.value ? null : controller.login,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Giriş Yap',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      );
}
