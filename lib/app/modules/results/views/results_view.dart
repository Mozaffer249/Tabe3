import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_avatar.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

import '../controllers/results_controller.dart';

class ResultsView extends GetView<ResultsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BasicAppBar(title: 'Results'.tr),
          Obx(
            () => Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    BasicDropdown<ClassModel>(
                      items: controller.authController.availableClasses,
                      value: controller.selectedClass,
                      hintText: 'Select class'.tr,
                      onChanged: (value) {
                        controller.selectedClass = value;
                      },
                      builder: (value) {
                        return Text(value.name!);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Students List'.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    BasicTextField(
                      prefix: SvgPicture.asset('assets/svg/search.svg'),
                      hintText: 'Search for student'.tr,
                    ),
                    SizedBox(height: 8),
                    if (controller.isLoading)
                      Container(
                        height: 400,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (controller.students.isEmpty)
                      Container(
                        height: 600,
                        child: Center(
                          child: Text('No data'.tr),
                        ),
                      )
                    else
                      ListView.separated(
                        itemCount: controller.students.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          final Student student =
                              controller.students.elementAt(index);
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.STUDENT_STATISTICS,
                                    arguments: {
                                      "student_id": student.studentId,
                                      "subject_id": controller.subject.id,
                                      "student": student,
                                    },
                                  );
                                },
                                title: Text('${student.studentName}'),
                                leading: BasicAvatarImage(
                                  width: 50,
                                  height: 50,
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1547082661-71362fc3969c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2064&q=80",
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 8);
                        },
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
