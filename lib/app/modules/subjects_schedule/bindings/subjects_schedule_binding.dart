import 'package:get/get.dart';

import '../controllers/subjects_schedule_controller.dart';

class SubjectsScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SubjectsScheduleController(),
    );
  }
}
