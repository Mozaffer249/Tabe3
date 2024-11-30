import 'package:get/get.dart';

import '../controllers/reset_pasword_controller.dart';

class ResetPaswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPaswordController>(
      () => ResetPaswordController(),
    );
  }
}
