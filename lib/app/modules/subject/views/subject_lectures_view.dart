import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';
import 'package:tabee3_flutter/app/modules/subject/controllers/subject_controller.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SubjectLecturesView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.isLoadingLectures)
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
                label: Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                onPresed: () async {
        await   controller.checkAndLaunchExternalURL(lesson.url!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
