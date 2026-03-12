import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseWigdetsScreen extends GetView<ChooseWigdetsController> {
  const ChooseWigdetsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorConstants.backgroundColor,
    appBar: AppBarWidget(
      context: context,
      titleWidget: const Text('Widget Çeşitleri'),
    ),
    body: Obx(
          () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Checkbox Çeşitleri", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Checkbox(
                  value: controller.isChecked.value,
                  onChanged: (val) => controller.isChecked.value = val!,
                ),
                const Text("Basit Checkbox"),
              ],
            ),
            CheckboxListTile(
              title: const Text("Checkbox List Tile"),
              subtitle: const Text("Beni hatırla"),
              value: controller.isChecked.value,
              onChanged: (val) => controller.isChecked.value = val!,
              controlAffinity: ListTileControlAffinity.leading, // Checkbox'ı sola alır
            ),
            const SizedBox(height: 20),

            // --- 3. RADIO VE RADIOLISTTILE ---
            const Text("Radio Çeşitleri", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: controller.selectedRadio.value,
                  onChanged: (val) => controller.selectedRadio.value = val!,
                ),
                const Text("Seçenek 1"),
                Radio<int>(
                  value: 2,
                  groupValue: controller.selectedRadio.value,
                  onChanged: (val) => controller.selectedRadio.value = val!,
                ),
                const Text("Seçenek 2"),
              ],
            ),
            RadioListTile<int>(
              title: const Text("Radio List Seçenek 1"),
              value: 1,
              groupValue: controller.selectedRadio.value,
              onChanged: (val) => controller.selectedRadio.value = val!,
            ),
            RadioListTile<int>(
              title: const Text("Radio List Seçenek 2"),
              value: 2,
              groupValue: controller.selectedRadio.value,
              onChanged: (val) => controller.selectedRadio.value = val!,
            ),
            const SizedBox(height: 20),

            // --- 4. SWITCH ---
            const Text("Switch", style: TextStyle(fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text("Bildirimleri Aç"),
              value: controller.isSwitched.value,
              onChanged: (val) => controller.isSwitched.value = val,
            ),
            const SizedBox(height: 20),

            // --- 5. SLIDER ---
            const Text("Slider (Değer Seçimi)", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Değer: ${controller.sliderValue.value.toInt()}"),
            Slider(
              value: controller.sliderValue.value,
              min: 0,
              max: 100,
              divisions: 10,
              label: controller.sliderValue.value.round().toString(),
              onChanged: (val) => controller.sliderValue.value = val,
            ),
          ],
        ),
      ),
    ),
  );
}