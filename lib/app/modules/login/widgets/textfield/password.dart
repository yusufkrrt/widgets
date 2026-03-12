import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPasswordTextField extends GetView<LoginController> {
  const LoginPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) => Obx(
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
      );
}
