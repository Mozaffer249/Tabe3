import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/modules/subject/controllers/subject_controller.dart';
import 'package:tabee3_flutter/app/utils/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

class SubjectAttendanceView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.isLoadingAttendance)
            Container(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (controller.attendance == null)
            Container(
              height: 500,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Attendance not available'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Column(
              children: [
                TableCalendar(
                  focusedDay: controller.attendance!.range!.from!,
                  currentDay: DateTime.now(),
                  onDaySelected: (DateTime selectedDate, DateTime focusDate) {
                    // controller.selectedDate = selectedDate;
                  },
                  firstDay: controller.attendance!.range!.from!,
                  lastDay: controller.attendance!.range!.to!,
                  enabledDayPredicate: (day) =>
                      !controller.attendance!.officialHolidays!
                          .contains(day.weekday) ||
                      controller.attendance!.holidays!
                          .where((e) => e.date!.isSameDate(day))
                          .isNotEmpty,
                  selectedDayPredicate: (day) => !controller
                      .attendance!.holidays!
                      .where((e) => e.date!.isSameDate(day))
                      .isNotEmpty,
                  // holidayPredicate: ,
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: {
                    CalendarFormat.month: "month",
                  },
                  calendarBuilders: CalendarBuilders(
                    disabledBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kMainColor,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('dd').format(day),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return Center(
                        child: Text(
                          DateFormat('dd').format(day),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('dd').format(day),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    holidayBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('dd').format(day),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  daysOfWeekHeight: 60,
                  // locale: Get.locale!.languageCode,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("attended".tr),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("didNotAttend".tr),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Color(0xff00CDDA),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("vacation".tr),
                      ],
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }
}
