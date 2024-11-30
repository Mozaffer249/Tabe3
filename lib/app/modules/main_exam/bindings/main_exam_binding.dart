import 'package:get/get.dart';

import '../controllers/main_exam_controller.dart';

class MainExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainExamController>(
      () => MainExamController(),
    );
  }
}
