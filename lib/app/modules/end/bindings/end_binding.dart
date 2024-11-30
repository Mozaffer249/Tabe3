import 'package:get/get.dart';

import '../controllers/end_controller.dart';

class EndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndController>(
      () => EndController(),
    );
  }
}
