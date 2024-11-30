import 'package:get/get.dart';

import '../controller/vehavior_controller.dart';

class BehaviorBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(BehaviorController());
  }

}