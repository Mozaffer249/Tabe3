import 'package:get/get.dart';

import '../controllers/add_announcement_controller.dart';

class AddAnnouncementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAnnouncementController>(
      () => AddAnnouncementController(),
    );
  }
}
