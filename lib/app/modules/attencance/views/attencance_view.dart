import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';

import '../controllers/attencance_controller.dart';

class AttencanceView extends GetView<AttencanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isSubmitting,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: BasicAppBar(title: 'Attendance'.tr),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicDropdown<ClassModel>(
                            items: controller.authController.availableClasses,
                            value: controller.selectedClass,
                            onChanged: (ClassModel? value) {
                              controller.selectedClass = value;
                            },
                            builder: (ClassModel value) => Text(value.name!),
                          ),
                          SizedBox(height: 16),
                          _calendarSection(),
                          SizedBox(height: 16),
                          BasicTextField(
                            hintText: 'Search for student'.tr,
                            onChanged: controller.filter,
                            prefix: SvgPicture.asset(
                              'assets/svg/search.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          ListTile(
                            title: Text('Students List'.tr),
                          ),
                          if (controller.isLoading)
                            Container(
                              height: 300,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else if (controller.filteredStudents.isEmpty)
                            Container(
                              height: 300,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No students in this class'.tr,
                                     ),
                                  ],
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              padding: EdgeInsets.only(bottom: 60),
                              itemCount: controller.filteredStudents.length,
                              shrinkWrap: true,
                              primary: false,
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
                              itemBuilder: (BuildContext context, int index) {
                                final Student student = controller.filteredStudents.elementAt(index);
                                return _buildStudentRow(student, (index + 1));
                              },
                            ),
                        ],
                      ),
                    ),
                    // if (controller.absanceIds.isNotEmpty)
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: BasicButton(
                          label: 'Save'.tr,
                          onPresed: () async {
                            final result = await showConfirmationDialog(
                              icon: Icon(
                                Icons.warning,
                                color: Colors.white,
                              ),
                              msg: 'absence of students'
                                  .trParams(<String, String>{
                                "total": "${controller.students.length}",
                                "absence": "${controller.absanceIds.length}"
                              }),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back(result: true);
                                  },
                                  child: Text('Submit'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back(result: false);
                                  },
                                  child: Text(
                                    'Cancel'.tr,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            );
                            if (result != null && result) {
                              controller.submit();
                            }
                          },
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildStudentRow(Student student, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.grey.shade300,
      elevation: 3,
      child: ListTile(
        title: Row(
          children: [
            Text(
              '${index}- ',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: Text('${student.studentName}')),
          ],
        ),
        onTap: () => controller.toggelAbsance(student.studentId!, !student.isAbsent),
        leading: Icon(
          Icons.circle_outlined,
          color: secondaryAppColor,
          size: 50.0,
        ),
        trailing: Checkbox(
          value: !student.isAbsent,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return kMainColor;
            }
            return Colors.grey;
          }),
          onChanged: (bool? value) {
            controller.toggelAbsance(student.studentId!, !student.isAbsent);
           // controller.toggelAbsance(student.studentId!, value!);
          },
        ),
      ),
    );
  }

  Widget _calendarSection() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(Duration(days: 365 * 10)),
      locale: Get.locale!.languageCode,
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: controller.selectedDate,
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: {
        CalendarFormat.week: "week",
      },
      currentDay: controller.selectedDate,
      onDaySelected: (selectedDate, focusDate) {
        controller.selectedDate = selectedDate;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      daysOfWeekVisible: false,
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('EE', Get.locale!.languageCode).format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(),
                Text(
                  DateFormat('d', 'en').format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(),
              ],
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF3A999F),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('EE', Get.locale!.languageCode).format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(),
                Text(
                  DateFormat('d', 'en').format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(),
              ],
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kMainColor.withOpacity(.7),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('EE', Get.locale!.languageCode).format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat('d', 'en').format(day),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
