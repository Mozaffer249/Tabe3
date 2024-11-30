import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:tabee3_flutter/app/data/common/announcement_card_widget.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

import '../controllers/announcements_controller.dart';

class AnnouncementsView extends GetView<AnnouncementsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isDeleting,
        child: Scaffold(
          body: Column(
            children: [
              BasicAppBar(title: 'Announcements'.tr),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Add Announcement'.tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          BasicButton(
                            onPresed: () async {
                              final result =
                                  await Get.toNamed(Routes.ADD_ANNOUNCEMENT);
                              if (result != null) {
                                controller.getAnnouncements();
                              }
                            },
                            label: Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      BasicDropdown<ClassModel>(
                        items: controller.authController.availableClasses,
                        value: controller.selectedClass,
                        onChanged: (ClassModel? value) {
                          controller.selectedClass = value;
                        },
                        builder: (ClassModel value) => Text(value.name!),
                      ),
                      SizedBox(height: 8),
                      if (controller.isLoading)
                        Container(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (controller.announcements.isEmpty)
                        Container(
                          height: Get.size.height / 1.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.hourglass_empty_sharp,
                                  size: 60,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No announcements'.tr,
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
                          itemCount: controller.announcements.length,
                          shrinkWrap: true,
                          primary: false,
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            final announcement = controller.announcements.elementAt(index);
                            return AnnouncementCardWidget(
                              onTap: () {
                                Get.toNamed(
                                  Routes.ANNOUNCEMENT_DETAILS,
                                  arguments: announcement,
                                );
                              },
                              announcement: announcement,
                              onDelete: () async {
                                final result =
                                    await showConfirmationDialog<bool>(
                                  msg: 'Are you sure you want to delete this announcemt?'.tr,
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
                                  controller.deleteAnnouncement(announcement.id!);
                                }
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 16),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
