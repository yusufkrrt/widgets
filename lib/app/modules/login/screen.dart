import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FlutterLogo(size: 72),
                    const SizedBox(height: 32),
                    Text(
                      'Hoş Geldiniz',
                      style: TextStyleConstants.heading1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hesabınıza giriş yapın',
                      style: TextStyleConstants.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      controller: controller.usernameController,
                      labelText: 'Kullanıcı Adı',
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Kullanıcı adı zorunlu' : null,
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => AppTextField(
                        controller: controller.passwordController,
                        labelText: 'Şifre',
                        obscureText: !controller.isPasswordVisible.value,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Şifre zorunlu' : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Giriş Yap',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
