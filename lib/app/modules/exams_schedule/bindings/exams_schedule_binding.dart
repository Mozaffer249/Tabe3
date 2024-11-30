import 'package:get/get.dart';

import '../controllers/exams_schedule_controller.dart';

class ExamsScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamsScheduleController>(
      () => ExamsScheduleController(),
    );
  }
}
