import 'package:get/get.dart';

import '../controllers/submit_attendance_controller.dart';

class SubmitAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitAttendanceController>(
      () => SubmitAttendanceController(),
    );
  }
}
