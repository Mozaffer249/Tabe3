import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/multi_message/contrloller/multi_message_controller.dart';

class MultiMessageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MultiMessageController());
  }

}