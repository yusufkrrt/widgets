import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'text_controller.dart';

class TextScreen extends GetView<TextController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Normal Text'),
            SizedBox(height: 16),
            Text('Bold Text', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Colored Text', style: TextStyle(color: Colors.blue)),
            SizedBox(height: 16),
            Text('Large Text', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
