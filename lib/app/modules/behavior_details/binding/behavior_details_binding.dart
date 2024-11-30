import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/behavior_details/controller/behavior_details_controller.dart';

class BehaviorDetailsBinding extends Bindings{
  @override
  void dependencies() {

    Get.put(BehaviorDetailsController());
  }

}