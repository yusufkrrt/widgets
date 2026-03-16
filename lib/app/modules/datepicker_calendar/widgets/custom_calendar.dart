import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';

class CustomCalendar extends GetView<DatepickerCalendarController> {
  const CustomCalendar({super.key});

  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Tablet yatay modda hücrelerin aşırı uzamasını engellemek için ratio ayarı
      final isLandscape = constraints.maxWidth > constraints.maxHeight;
      final dynamicAspectRatio = isLandscape ? 1.8 : 1.0;

      return Obx(() {
        final focused = controller.focusedDay.value;
        final selected = controller.selectedDay.value;
        final year = focused.year;
        final month = focused.month;
        final firstOfMonth = DateTime(year, month, 1);
        final weekdayOfFirst = firstOfMonth.weekday;
        final leadingEmpty = weekdayOfFirst - 1;
        final daysInMonth = DateTime(year, month + 1, 0).day;

        return Center( // Geniş ekranlarda ortalamak için
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600), // Takvimin aşırı yayılmasını engeller
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () => controller.focusedDay.value = DateTime(year, month - 1, 1),
                      ),
                      Text(
                        '${focused.year} - ${focused.month.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => controller.focusedDay.value = DateTime(year, month + 1, 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz']
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: (day == 'Cmt' || day == 'Paz') ? Colors.red : null,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: dynamicAspectRatio,
                    ),
                    itemCount: leadingEmpty + daysInMonth,
                    itemBuilder: (context, index) {
                      final dayNum = index - leadingEmpty + 1;
                      if (dayNum <= 0) return const SizedBox.shrink();

                      final date = DateTime(year, month, dayNum);
                      final isSelected = selected != null && _isSameDay(selected, date);
                      final isToday = _isSameDay(DateTime.now(), date);
                      final events = controller.getEventsForDay(date);

                      return GestureDetector(
                        onTap: () {
                          controller.selectedDay.value = date;
                          controller.focusedDay.value = date;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).colorScheme.primary : null,
                            borderRadius: BorderRadius.circular(8),
                            border: isToday && !isSelected
                                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 1.5)
                                : null,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  dayNum.toString(),
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : null,
                                    fontWeight: (isToday || isSelected) ? FontWeight.bold : FontWeight.normal,
                                    fontSize: isLandscape ? 12 : 14, // Yatayda yazıyı biraz küçülttük
                                  ),
                                ),
                              ),
                              if (events.isNotEmpty)
                                Positioned(
                                  bottom: 2,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20), // Alt boşluk
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
