import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/add_test/controller/add_test_controller.dart';

class AddTestBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(AddTestController());

  }

}