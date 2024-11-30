import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/add_question/controllers/add_question_controller.dart';

class AddQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddQuestionController());
  }

}