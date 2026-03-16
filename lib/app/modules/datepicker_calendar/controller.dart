import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DatepickerCalendarController extends GetxController {
  final isLoading = false.obs;
  final selectedDay = Rxn<DateTime>();
  final focusedDay = DateTime.now().obs;

  // simple events map for demo purposes
  final events = <DateTime, List<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      isLoading.value = true;
      final today = DateTime.now();
      events[_stripTime(today)] = ['Demo event'];
      events[_stripTime(today.add(const Duration(days: 5)))] = ['Meeting'];
    } on Exception catch (_) {
      // handle error
    } finally {
      isLoading.value = false;
    }
  }

  List<String> getEventsForDay(DateTime day) => events[_stripTime(day)] ?? [];

  DateTime _stripTime(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
