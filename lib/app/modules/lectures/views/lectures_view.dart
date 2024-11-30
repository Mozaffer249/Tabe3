import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/lectures_controller.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';

class LecturesView extends GetView<LecturesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isDeleting,
          child: RefreshIndicator(
            onRefresh: () async => await controller.getLessons(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: BasicAppBar(title: 'Lectures'.tr),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Add new lecture'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 80,
                              height: 52,
                              child: BasicButton(
                                label: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPresed: () async {
                                  final result = await Get.toNamed(
                                    Routes.ADD_LECTURE,
                                    arguments: controller.subject,
                                  );

                                  if (result != null) {
                                    controller.getLessons();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        BasicDropdown<ClassModel>(
                          items: controller.authController.availableClasses,
                          value: controller.selectedClass,
                          onChanged: (ClassModel? value) {
                            controller.selectedClass = value;
                          },
                          builder: (ClassModel value) => Text(value.name!),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lecture List'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        if (controller.isLoading)
                          Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (controller.lessons.isEmpty)
                          Container(
                            height: 500,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No lectures for this subject'.tr,
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
                          ListView.separated(
                            itemCount: controller.lessons.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              final Lesson lesson = controller.lessons.elementAt(index);
                              return _buildLessonRow(lesson);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(
                                height: 8,
                                thickness: 2,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLessonRow(Lesson lesson) {
    return Container(
      child: ListTile(
        title: Text(
          '${lesson.name}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: BasicButton(
                raduis: 8,
                outline: true,
                buttonColor: Colors.red,
                label: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPresed: () async {
                  final result = await showConfirmationDialog<bool>(
                    msg: 'Are you sure you want to delete this lesson?'.tr,
                    icon: Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: Text(
                          'Yes'.tr,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: Text('No'.tr),
                      ),
                    ],
                  );
                  if (result != null && result) {
                    controller.deleteLesson(lesson.id!);
                  }
                },
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 40,
              height: 40,
              child: BasicButton(
                raduis: 8,
                label: Icon(
                  Icons.file_download,
                  color: Colors.white,
                ),
                onPresed: () async {
                  controller.ViewLesson(lesson);
                  },
              ),
            ),
          ],
        ),
        // leading: Image.,
      ),
    );
  }
}
