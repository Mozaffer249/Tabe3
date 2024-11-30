import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/tests/controllers/tests_controller.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TestsController());
  }

}