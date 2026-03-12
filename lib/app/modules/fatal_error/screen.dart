import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:ogrenme/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FatalErrorScreen extends GetView<FatalErrorController> {
  const FatalErrorScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 80, color: Color(0xFFB71C1C)),
                const SizedBox(height: 24),
                Text(
                  'Bir Hata Oluştu',
                  style: TextStyleConstants.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Text(
                    controller.errorMessage.value,
                    style: TextStyleConstants.body,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed<void>(AppPaths.login),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Giriş Sayfasına Dön'),
                ),
              ],
            ),
          ),
        ),
      );
}
