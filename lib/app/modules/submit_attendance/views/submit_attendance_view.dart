import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/submit_attendance_controller.dart';
import 'package:tabee3_flutter/app/data/models/studnet_attendance_model.dart';

class SubmitAttendanceView extends GetView<SubmitAttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: 'Submit Attendance'.tr,
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isSubmiting,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    '${controller.report.classname}',
                    style: Get.theme.textTheme.titleMedium,
                  ),
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
                if (controller.isLoading)
                  Container(
                    height: 500,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
             if(  controller.filteredstudentslist.isNotEmpty)
               if(!controller.isAttendenceConfirmed.value)
                 ListView.separated(
                   itemCount: controller.filteredstudentslist.length,
                   shrinkWrap: true,
                   primary: false,
                   padding: const EdgeInsets.all(8),
                   itemBuilder: (BuildContext context, int index) {
                     final student = controller.filteredstudentslist.elementAt(index);
                     return _buildStudentCard(index, student);
                   },
                   separatorBuilder: (BuildContext context, int index) =>
                       SizedBox(),
                 )
                else _buildStudentsTable()

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => (controller.authController.currentUser!.attendanceAdmin &&
                controller.report.state != "darft" && !controller.isAttendenceConfirmed.value)
            ? Container(
                padding: const EdgeInsets.all(16),
                child: BasicButton(
                  label: 'Submit'.tr,
                  onPresed: controller.updateAttendnance,
                ),
              )
            : SizedBox(),
      ),
    );
  }

  Card _buildStudentCard(int index, Student student) {
    return Card(
      color: Colors.grey.shade100,
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    '${index+1}- ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Text('${student.studentName}')),
                ],
              ),
              leading: Icon(
                Icons.circle_outlined,
                color: secondaryAppColor,
                size: 50.0,
              ),
              onTap: ()=>controller.toggelAbsance(index, student.isAbsent),
              trailing:student.isAbsent ? Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                            Get.defaultDialog(
                                title: "Call".tr,
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    student.parentMobile==false  ||student.parentMobile ==null ?
                                    Container(child: Text("No Phone".tr),) : GestureDetector(
                                        onTap: ()async{
                                          final tel = "tel:${student.parentMobile}";
                                          if (await canLaunchUrlString(tel)) {
                                            await launchUrlString(tel);
                                          }
                                        },
                                        child: Text("${student.parentMobile}")
                                    ),

                                    Divider(),
                                    student.parentPhone == false ||  student.parentPhone ==null ?
                                    Container(child: Text("No Phone".tr),): GestureDetector(
                                        onTap: ()async{
                                          final tel = "tel:${student.parentPhone}";
                                          if (await canLaunchUrlString(tel)) {
                                            await launchUrlString(tel);
                                          }
                                        },
                                        child: Text("${student.parentPhone}")
                                    )
                                  ],
                                )
                            );
                      },
                      icon: Icon(Icons.call,color: kMainColor,size: 20),
                    ),
                    Checkbox(
                      value: !student.isAbsent,
                      fillColor: MaterialStateProperty.resolveWith(
                            (states) {
                          if (states.contains(MaterialState.selected)) {
                            return kMainColor;
                          }
                          return Colors.grey;
                        },
                      ),
                      onChanged: (bool? value) {
                        controller.toggelAbsance(index,value);
                      },
                    ),
                  ],
                ),
              ): Checkbox(
                value: !student.isAbsent,
                fillColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return kMainColor;
                    }
                    return Colors.grey;
                  },
                ),
                onChanged: (bool? value) {
                  controller.toggelAbsance(index,value);
                },
              ),

            ),
            SizedBox(height: 5,),
           if(student.isAbsent) BasicTextField(
              hintText: 'Absence Reason'.tr,
              onChanged: (value) {
                student.absentReason=value;
                print(student.absentReason);
              },
            ),
          ],
        ),
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
          Table(
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                    color: kMainColor),
                children: <Widget>[
                  Text(
                    'Attendence Report'.tr,
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
          SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Color(0xFFC4C4C4)),
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(
                    color: kMainColor),
                children: <Widget>[
                  buildTitleText(
                    'Studen Name'.tr,
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
              ...controller.filteredstudentslist
                  .asMap()
                  .map((int key, Student value) =>
                  MapEntry(key,
                      TableRow(
                        decoration: BoxDecoration(color: key % 2 != 0 ? kMainColor.withOpacity(.3) : Colors.transparent,),
                        children: <Widget>[
                          buildTitleText('${value.studentName!}', whiteColor: false,),

                          value.isAbsent ? Padding(padding: const EdgeInsets.symmetric(vertical: 30), child: Icon(Icons.check_circle,color: kMainColor,size: 38),): Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Icon(Icons.report,color: Colors.redAccent,size: 38),
                          ) ,
                          buildTitleText('${value.absentReason != "false" && value.absentReason != null ? value.absentReason:""}', whiteColor: false,),

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

        ),
      ),
    );
  }
}
