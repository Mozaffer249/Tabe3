import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/choice.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/question.dart';
import 'package:tabee3_flutter/app/modules/test_questions/controllers/test_questions_controller.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AddQuestionController extends GetxController {
  TestQuestionController testQuestionController =Get.find<TestQuestionController>();

  final _isReLoading = false.obs;
  bool get isReLoading => _isReLoading.value;

  final Rxn<ClassModel> _selectedType = Rxn();
  ClassModel? get selectedType => _selectedType.value;
  set selectedType(ClassModel? model) => _selectedType(model);

  final RxList<TextEditingController>_optionsController = RxList<TextEditingController>.generate(4, (_) => TextEditingController());
  RxList<TextEditingController> get optionsController => _optionsController;

  RxList<Choice> _choices = RxList<Choice>.generate(4, (index) => Choice(isCorrect:index ==0 ? true: false));
  RxList<Choice> get choices => _choices;
  set choicesset(RxList<Choice> value) {_choices = value;}

  TextEditingController questionController=TextEditingController();

  RxInt _testId = 0.obs;

  RxInt _correctOption = 0.obs;
  RxInt get correctOption => _correctOption;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments !=null)_testId.value =Get.arguments;
    _selectedType(ClassModel(id: 1,name: "mcq"));


  }


void addQuestion()async{
    if(questionController.text.isEmpty)
      {
        showSnackbar(title: "", message:'Insert the question'.tr);
        return ;
      }

    if(_selectedType.value!.name == "mcq")
      {
        if(_choices.length ==4)
          {
            for(var choice in _choices.value)
              {
                if(choice.text == null ||choice.text ==""  ) {
                  showSnackbar(title: "", message: "Insert all choices".tr);
                  return ;
                  }
              }

          }
      }

    Question question=Question(
      type:_selectedType.value!.name! ,
      text:questionController.text ,
      testId: _testId.value,
      choices:_choices
    );
    testQuestionController.questions.add(question);
    testQuestionController.questions.refresh();
    Get.back(result: true);
}

void toggleMcqQustionType()
{
   _selectedType.value=ClassModel(id: 1,name: "mcq");
  _correctOption.value =0;
  _choices = RxList.generate(4, (index) => Choice(isCorrect:index ==0 ? true: false));
  // print("********************${_choices.value.length}");
}

  void toggleTrueFalseQustionType()
  {
    _selectedType.value=ClassModel(id: 2,name: "true or false");
   _correctOption.value =0;
    _choices = RxList.generate(2, (index) => Choice(isCorrect:index ==0 ? true: false,text: index ==0 ? "True": "False"));
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    for (final controller in _optionsController) {
      controller.dispose();
    }
  }
}
