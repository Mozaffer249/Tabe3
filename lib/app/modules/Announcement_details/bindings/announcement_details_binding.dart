import 'package:get/get.dart';

import '../controllers/announcement_details_controller.dart';

class AnnouncementDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnnouncementDetailsController());
  }
}
