import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUsernameTextField extends GetView<LoginController> {
  const LoginUsernameTextField({super.key});

  @override
  Widget build(BuildContext context) => AppTextField(
        controller: controller.usernameController,
        labelText: 'Kullanıcı Adı',
        prefixIcon: const Icon(Icons.person_outline),
        validator: (v) =>
            v == null || v.isEmpty ? 'Kullanıcı adı zorunlu' : null,
      );
}
