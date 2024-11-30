import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/question.dart';
import 'package:tabee3_flutter/app/modules/test_questions/controllers/test_questions_controller.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class TestQuestionsView extends GetView<TestQuestionController> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Obx(
      ()=> LoadingOverlay(
        isLoading: controller.isReLoading,
        child: Scaffold(

          appBar: BasicAppBar(title: 'Tests Questions'.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // BasicAppBar(title: 'Tests Questions'.tr),
                if (controller.questions.value.isEmpty)
                  Container(
                    height: Get.size.height / 1.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hourglass_empty_sharp,
                            size: 60,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tests'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    height: size.height,
                    padding: EdgeInsets.only(bottom: size.height*.16),
                    child: ListView.separated(
                      itemCount: controller.questions.value.length,
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.all(16),
                      itemBuilder: (BuildContext context, int index) {
                        final question = controller.questions.value.elementAt(index);
                        return  questionCard(question,size);
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16),
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.ADD_QUESTION,arguments: controller.test.id);
              },
              backgroundColor: kMainColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
   Widget questionCard(Question question,var size){
    return Flexible(
      child: Container(

        // height: size.height*.52,
        width: size.width,
        // color: Colors,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8) ),
                  color: kMainColor,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                          question.text!,
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                    ),

                  ],
                ),
              ),
              Divider(),
              ListView.separated(
                separatorBuilder: (context, innerIndex) => Divider(),
                itemCount: question.choices!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final choice =  question.choices!.elementAt(index);
                  return ListTile(
                      title: Text("${choice.text!}"),
                    trailing:choice.isCorrect! ? Icon( Icons.check_circle,color: Colors.green,):Icon(Icons.clear,color: Colors.redAccent),

                  );
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){},  icon: Icon(Icons.delete_forever,color: Colors.red,)),
                  IconButton(onPressed: (){},  icon: Icon(Icons.update_sharp,color: kMainColor,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
