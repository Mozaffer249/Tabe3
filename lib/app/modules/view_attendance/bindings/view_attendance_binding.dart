import 'package:get/get.dart';

import '../controllers/view_attendance_controller.dart';

class ViewAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewAttendanceController>(
      () => ViewAttendanceController(),
    );
  }
}
