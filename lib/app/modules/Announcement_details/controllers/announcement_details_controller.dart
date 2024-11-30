import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/announcement_model.dart';

class AnnouncementDetailsController extends GetxController {
  late Announcement announcement;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      announcement = Get.arguments as Announcement;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
