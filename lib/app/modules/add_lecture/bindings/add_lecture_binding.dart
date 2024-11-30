import 'package:get/get.dart';

import '../controllers/add_lecture_controller.dart';

class AddLectureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLectureController>(
      () => AddLectureController(),
    );
  }
}
