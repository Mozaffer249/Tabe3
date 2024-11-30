import 'package:get/get.dart';

import '../controllers/edit_exams_schedule_controller.dart';

class EditExamsScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditExamsScheduleController>(
      () => EditExamsScheduleController(),
    );
  }
}
