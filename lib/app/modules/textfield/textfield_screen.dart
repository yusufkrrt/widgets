import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'textfield_controller.dart';

class TextFieldScreen extends GetView<TextFieldController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField Widget')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => TextField(
                obscureText: !controller.isPasswordVisible.value,
                onChanged: (value) => controller.secretText.value = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                    },
                  ),
                ),
              )),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.text.value = value,
                decoration: InputDecoration(
                  labelText: 'Hint Textli Input Alanı',
                  border: OutlineInputBorder(),
                  hintText: 'selam',

                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.text.value = value,
                decoration: InputDecoration(
                  labelText: 'Filled Input Alanı',
                  border: OutlineInputBorder(),
                  filled: true
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.text.value = value,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Obx(() => controller.isPasswordVisible.value
                  ? Text("Şifre görünür | Yazılanlar: ${controller.text.value} | Şifre Metni: ${controller.secretText.value}")
                  : Text('Typed: ${controller.text.value}')),
            ],
          ),
        ),
      ),
    );
  }
}
