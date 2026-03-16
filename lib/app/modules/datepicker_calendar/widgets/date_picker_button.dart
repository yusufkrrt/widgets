import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import '../controller.dart';

class DatePickerButton extends GetView<DatepickerCalendarController> {
  const DatePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedDay.value;
        final label = selected == null
          ? tr('datepicker.select_date')
          : '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';

      return ElevatedButton.icon(
        icon: const Icon(Icons.date_range),
        label: Text(label),
        onPressed: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: selected ?? now,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: context.locale,
          );
          if (picked != null) {
            controller.selectedDay.value = picked;
            controller.focusedDay.value = picked;
          }
        },
      );
    });
  }
}
