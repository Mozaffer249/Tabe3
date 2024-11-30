import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/test_questions/controllers/test_questions_controller.dart';

class TestQuestionsBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(TestQuestionController());
  }

}