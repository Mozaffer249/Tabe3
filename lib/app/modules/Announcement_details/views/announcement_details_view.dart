import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/modules/announcements/controllers/announcements_controller.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../controllers/announcement_details_controller.dart';

class AnnouncementDetailsView extends GetView<AnnouncementDetailsController> {
  final user = Get.find<AuthController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BasicAppBar(
              title: controller.announcement.name!,
              actions: [
                if (user!.userType == "T")
                  IconButton(
                    onPressed: () async {
                      final result = await showConfirmationDialog<bool>(
                        msg: 'Are you sure you want to delete this announcemt?'
                            .tr,
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
                        Get.find<AnnouncementsController>()
                            .deleteAnnouncement(controller.announcement.id!);
                        Get.back();
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Zoom(
                backgroundColor: Colors.white,
                centerOnScale: false,
                child: Html(
                  data: controller.announcement.body,
                  style: {
                    "a": Style(
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.underline,
                    ),
                  },
                  // onLinkTap: (link, _, __, ___) async {
                  //   if (link != null) {
                  //     if (await canLaunchUrlString(link)) {
                  //       await launchUrlString(link);
                  //     } else {
                  //       showSnackbar(
                  //           title: null,
                  //           message:
                  //               'Cannot open link'.trParams({"link": link}));
                  //     }
                  //   }
                  // },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
