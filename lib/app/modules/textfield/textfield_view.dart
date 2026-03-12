import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'textfield_controller.dart';

class TextFieldView extends GetView<TextFieldController> {
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
              TextField(
                onChanged: (value) => controller.text.value = value,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Obx(() => Text('Typed: ${controller.text.value}')),
            ],
          ),
        ),
      ),
    );
  }
}
