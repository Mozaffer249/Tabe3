import 'package:get/get.dart';

import '../controllers/all_subjects_controller.dart';

class AllSubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllSubjectsController>(
      () => AllSubjectsController(),
    );
  }
}
