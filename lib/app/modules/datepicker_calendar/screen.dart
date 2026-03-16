import 'package:ogrenme/app/core/core.dart';
import 'package:ogrenme/app/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/date_picker_button.dart';
import 'widgets/calendar_view.dart';
import 'widgets/custom_calendar.dart';

class DatepickerCalendarScreen extends GetView<DatepickerCalendarController> {
  const DatepickerCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        appBar: AppBarWidget(
          context: context,
          titleWidget: Text(tr('datepicker.title')),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DatePickerButton(),
                      const SizedBox(height: 12),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(tabs: [Tab(text: tr('tabs.table')), Tab(text: tr('tabs.custom'))]),
                              const SizedBox(height: 8),
                              const Expanded(
                                child: TabBarView(
                                  children: [
                                    CalendarView(),
                                    CustomCalendar(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
}
