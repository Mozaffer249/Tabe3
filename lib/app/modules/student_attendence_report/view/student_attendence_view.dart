import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/studnet_attendance_model.dart';
import 'package:tabee3_flutter/app/modules/student_attendence_report/controller/student_attendence_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class  StudentAttendenceReporView extends GetView<StudentAttendenceCotroller>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: BasicAppBar(
       title: "Attendence Report".tr,
     ),
     body: Obx(
           () => LoadingOverlay(
         isLoading: controller.isSubmitting,
         child:SingleChildScrollView(
           padding: const EdgeInsets.all(16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 16),
               Text("From Date".tr),
               _startDateCalendarSection(),
               SizedBox(height: 16),
               Text("To Date".tr),
               _endDateCalendarSection(),
               if (controller.filteredStudnets.isEmpty)
                 Container(
                   height: 300,
                   child: Center(
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         SizedBox(height: 16),
                         Text(
                           'No Record'.tr,
                          ),
                       ],
                     ),
                   ),
                 )
               else _buildStudentsTable()
             ],
           ),
         )
   )));
  }
  Widget _startDateCalendarSection() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(Duration(days: 365 * 10)),
      locale: Get.locale!.languageCode,
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: controller.selectedStartDate,
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: {
        CalendarFormat.week: "week",
      },
      currentDay: controller.selectedStartDate,
      onDaySelected: (selectedDate, focusDate) {
        controller.selectedStartDate = selectedDate;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
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
  Widget _endDateCalendarSection() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(Duration(days: 365 * 10)),
      locale: Get.locale!.languageCode,
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: controller.selectedEndDate,
      calendarFormat: CalendarFormat.week,
      availableCalendarFormats: {
        CalendarFormat.week: "week",
      },
      currentDay: controller.selectedEndDate,
      onDaySelected: (selectedDate, focusDate) {
        controller.selectedEndDate = selectedDate;
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
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
  Widget _buildStudentsTable()
  {
    return  Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 16),
          SizedBox(height: 16),
          ListTile(
            trailing: PopupMenuButton<String>(
              initialValue: controller.selectedFilter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter By'.tr,

                  ),
                  SizedBox(width: 8),
                  Icon(Icons.filter_alt_rounded),
                ],
              ),
              onSelected: (value) {
                controller.selectedFilter = value;
              },
              itemBuilder: (context) => controller.filterBy
                  .map((e) => PopupMenuItem<String>(
                value: e,
                child: Text(e),
                onTap: () {
                  controller.selectedFilter = e;
                },
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 16),

          Table(
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                    color: kMainColor),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Attendence Report'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.normal,
                        ),
                      ),
                      Text(
                        controller.studnets.first.name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.normal,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Color(0xFFC4C4C4)),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                    color: kMainColor),
                children: <Widget>[
                  buildTitleText(
                    'Date'.tr,
                    whiteColor: true,
                  ),
                  buildTitleText(
                    'IsAbsent'.tr,
                    whiteColor: true,
                  ),
                  buildTitleText(
                    'Absence Reason'.tr,
                    whiteColor: true,
                  ),
                ],
              ),
              ...controller.filteredStudnets
                  .asMap()
                  .map((int key, StudentAttendance value) =>
                  MapEntry(key,
                      TableRow(
                        decoration: BoxDecoration(color: key % 2 != 0 ? kMainColor.withOpacity(.3) : Colors.transparent,),
                        children: <Widget>[
                          buildTitleText('${value.date!}', whiteColor: false,),
                          !value.present! ? Padding(padding: const EdgeInsets.symmetric(vertical: 30), child: Icon(Icons.check_circle,color: kMainColor,size: 38),): Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Icon(Icons.report,color: Colors.redAccent,size: 38),
                          ) ,
                          buildTitleText('${value.absentReason != "false" && value.absentReason != null && value.absentReason != false ? value.absentReason:""}', whiteColor: false,),
                        ],
                      )))
                  .values
                  .toList()
            ],
          ),
          SizedBox(height: 8),

        ],
      ),
    );
  }
  Widget buildTitleText(String text, {required bool whiteColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: whiteColor ? Colors.white : Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 15
        ),
      ),
    );
  }
}