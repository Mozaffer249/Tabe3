import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/lecture_details/controller/lecture_details_controller.dart';

class LectureDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LecureDetailsController());
  }

}