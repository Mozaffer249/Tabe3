import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/models/teacher_exam.dart';
import 'package:tabee3_flutter/app/utils/extensions.dart';

import 'package:table_calendar/table_calendar.dart';

import '../controllers/exams_schedule_controller.dart';

class ExamsScheduleView extends GetView<ExamsScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: "examsSchedule".tr,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      _buildCalendar(),
                      SizedBox(height: 16),
                      ListTile(
                        title: Text(
                          'exams'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (controller.filteredExams.isEmpty)
                        Container(
                          child: Center(
                            child: Text('No exams on this date'.tr),
                          ),
                        )
                      else
                        ListView.separated(
                          itemCount: controller.filteredExams.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            final GeneralExam exam =
                                controller.filteredExams.elementAt(index);
                            return _buildExamRow(exam);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 8),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: controller.selectedDate,
      currentDay: controller.selectedDate,
      onDaySelected: (DateTime selectedDate, DateTime focusDate) {
        controller.selectedDate = selectedDate;
      },
      firstDay: DateTime(DateTime.now().year - 1),
      lastDay: DateTime(DateTime.now().year + 1),
      selectedDayPredicate: (day) {
        final dates =
            controller.exams.where((element) => element.date!.isSameDate(day));
        return dates.isNotEmpty;
      },
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: {
        CalendarFormat.month: "month",
      },
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              DateFormat('dd').format(day),
            ),
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor,
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
      daysOfWeekHeight: 44,
      locale: Get.locale!.languageCode,
    );
  }

  Widget _buildExamRow(GeneralExam exam) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF5F5F5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${exam.subjectId}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 20,
                color: Color(0xFF6F6F6F),
              ),
              SizedBox(width: 8),
              Text(
                '${exam.supervisior}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.timer_rounded,
                size: 20,
                color: Color(0xFF6F6F6F),
              ),
              SizedBox(width: 8),
              Text(
                '${exam.startTime} - ${exam.startTime}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
