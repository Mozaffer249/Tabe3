import 'package:get/get.dart';

class BehaviorDetailsController extends GetxController
{
  var behavior;
  @override
  void onInit() {
    super.onInit();

    if(Get.arguments != null)
      {
        behavior=Get.arguments;
      }
  }
}