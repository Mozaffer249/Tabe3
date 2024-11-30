import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/data/models/Tests.dart';
import 'package:tabee3_flutter/app/data/models/choice.dart';
import 'package:tabee3_flutter/app/data/models/question.dart';

class TestQuestionController extends GetxController {

  final _isReLoading = false.obs;
  bool get isReLoading => _isReLoading.value;

 late  Tests test ;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) test =Get.arguments;

  }



  RxList<Question> questions = [
    Question(
      id: 1,
      text: 'What is the capital of France?',
      type:QuestionType.MCQ.toString(),
      choices: [
        Choice(id: 1, text: 'Paris', isCorrect: true),
        Choice(id: 2, text: 'Madrid', isCorrect: false),
        Choice(id: 3, text: 'Berlin', isCorrect: false),
        Choice(id: 4, text: 'London', isCorrect: false),
      ],
    ),
    Question(
      id: 2,
      text: 'Which is the highest mountain in the world?',
      type: QuestionType.MCQ.toString(),
      choices: [
        Choice(id: 1, text: 'Mount Everest', isCorrect: true),
        Choice(id: 2, text: 'K2', isCorrect: false),
        Choice(id: 3, text: 'Makalu', isCorrect: false),
        Choice(id: 4, text: 'Cho Oyu', isCorrect: false),
      ],
    ),
    Question(
      id: 3,
      text: 'True or false: The Great Barrier Reef is located in the Atlantic Ocean.',
      type: QuestionType.TrueFalse.toString(),
      choices: [
        Choice(id: 1, text: 'True', isCorrect: false),
        Choice(id: 2, text: 'False', isCorrect: true),
      ],
    ),
  ].obs;

}