import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'button_controller.dart';

class ButtonScreen extends GetView<ButtonController> {
  const ButtonScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButtonTypesExample(),
    );
  }
}

class ButtonTypesExample extends StatelessWidget {
  const ButtonTypesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: const <Widget> [
            Spacer(),
            ButtonTypesGroup(enabled: true),
            ButtonTypesGroup(enabled: false ),
            Spacer(),
          ],
        ),
    );
  }
}
class ButtonTypesGroup extends StatelessWidget {
  const ButtonTypesGroup({super.key, required this.enabled});
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;
    return Padding (padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
            ElevatedButton(onPressed: onPressed, child: const Text("Elevated Button")),
            FilledButton(onPressed: onPressed, child: const Text("Filled Button")),
            FilledButton.tonal(onPressed: onPressed, child: const Text("Filled Tonal Button")),
            OutlinedButton(onPressed: onPressed, child: const Text("Outlined Button")),
            TextButton(onPressed: onPressed, child: const Text("Text Button")),
        ],
      ),
    );
  }
}
