import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/view_attendance_controller.dart';
import 'package:tabee3_flutter/app/data/models/attendance_report_model.dart';

class ViewAttendanceView extends GetView<ViewAttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: 'View Attendance'.tr,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              if (controller.isLoading)
                Container(
                  height: 450,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (controller.attendanceReport.isNotEmpty)
                ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.attendanceReport.length,
                  shrinkWrap: true,
                  primary: false,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    final report = controller.attendanceReport.elementAt(index);
                    return _buildReportCard(report);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 8),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildReportCard(AttendanceReport report) {
    return Card(
      child: InkWell(
        onTap: () async {
          final result =
              await Get.toNamed(Routes.SUBMIT_ATTENDANCE, arguments: report);
          if (result != null && result) {
            controller.getReports();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${report.classname}',
                style: Get.theme.textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Date:'.tr,

                  ),
                  SizedBox(width: 8),
                  Text(
                    DateFormat('EEEE, dd/MMM/yyyy', Get.locale!.languageCode)
                        .format(report.date!),
                   ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Total studnets:'.tr,

                  ),
                  SizedBox(width: 8),
                  Text(
                    "${report.totalStudent}",
                   ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Presences:'.tr,
                        style: Get.theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${report.totalPresences}",
                        style: Get.theme.textTheme.bodySmall!.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Total absence:'.tr,
                        style: Get.theme.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${report.totalAbsent}",
                        style: Get.theme.textTheme.bodySmall!.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
