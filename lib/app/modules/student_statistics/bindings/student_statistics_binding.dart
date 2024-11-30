import 'package:get/get.dart';

import '../controllers/student_statistics_controller.dart';

class StudentStatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentStatisticsController>(
      () => StudentStatisticsController(),
    );
  }
}
