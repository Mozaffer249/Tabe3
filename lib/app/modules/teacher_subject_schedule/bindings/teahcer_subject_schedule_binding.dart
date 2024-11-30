import 'package:get/get.dart';

import '../controllers/teacher_subject_schedule_controller.dart';

class TeacherSubjectScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherSubjectScheduleController>(
      () => TeacherSubjectScheduleController(),
    );
  }
}
