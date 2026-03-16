import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller.dart';

class CalendarView extends GetView<DatepickerCalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final focused = controller.focusedDay.value;
      final selected = controller.selectedDay.value;

      return Column(
        children: [
          TableCalendar<String>(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: focused,
            selectedDayPredicate: (day) => selected != null && isSameDay(day, selected),
            onDaySelected: (day, focus) {
              controller.selectedDay.value = day;
              controller.focusedDay.value = focus;
            },
            eventLoader: (day) => controller.getEventsForDay(day),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final sel = controller.selectedDay.value ?? controller.focusedDay.value;
              final items = controller.getEventsForDay(sel);
              if (items.isEmpty) {
                return Center(child: Text(tr('calendar.no_events')));
              }
              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text(items[index]),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
