
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/add_behavior/controller/add_behavior_controller.dart';

class AddBehaviorBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddBehaviorController());
  }

}