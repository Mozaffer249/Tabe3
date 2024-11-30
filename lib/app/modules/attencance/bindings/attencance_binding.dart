import 'package:get/get.dart';

import '../controllers/attencance_controller.dart';

class AttencanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttencanceController>(
      () => AttencanceController(),
    );
  }
}
