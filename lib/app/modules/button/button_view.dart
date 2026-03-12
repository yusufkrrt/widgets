import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'button_controller.dart';

class ButtonView extends GetView<ButtonController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('ElevatedButton'),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: Text('OutlinedButton'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Text('TextButton'),
            ),
          ],
        ),
      ),
    );
  }
}
