import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/models/choice.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/add_question/controllers/add_question_controller.dart';

class AddQuestionView extends GetView<AddQuestionController> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body:Obx(() => LoadingOverlay(
          isLoading: controller.isReLoading,
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BasicAppBar(title: 'Add Question'.tr),
                SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    GestureDetector(
                      onTap: ()=> controller.toggleMcqQustionType(),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        child: Center(
                          child: Text("mcq",
                            style: TextStyle(
                                color:  controller.selectedType!.name=="mcq" ?Colors.white :Colors.black54
                            ),
                          ),
                        ),
                        height: size.height*.06,
                        width: size.width*.5,
                        decoration: BoxDecoration(
                            color:   controller.selectedType!.name=="mcq" ?kMainColor :Colors.white
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>controller.toggleTrueFalseQustionType(),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        child: Center(
                          child: Text("true or false",
                            style: TextStyle(color:  controller.selectedType!.name=="true or false" ?Colors.white :Colors.black54
                            ),),
                        ),
                        height: size.height*.06,
                        width: size.width*.5,
                        decoration: BoxDecoration(
                            color:   controller.selectedType!.name=="true or false" ?kMainColor :Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Insert the question'.tr,
                        // style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BasicTextField(
                          controller: controller.questionController,
                          readOnly: false,
                          hintText: 'Insert the question'.tr,
                        ),
                      )
                    ],
                  ),
                ),
                if(controller.selectedType!.name=="mcq")
                  _buildMcqQuestion(size)
                else _buildTrueOrFalseQuestion(size),


                Container(
                  padding: EdgeInsets.all(8),
                  child: BasicButton(
                    onPresed: (){
                      // print(controller.questionController.text);
                    controller.addQuestion();
                    },
                    label: "Submit question".tr,
                  ),
                )
              ],
            ),
          ),

    )));
  }
  Widget _buildMcqQuestion(final size)

  {
    return  Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
        ...List.generate(4, (index){
          return ListTile(
            title: Container(
              width: size.width *.6,
              child: BasicTextField(
                controller: controller.optionsController[index],
                labelText: "Option no".tr +" ${index+1}",
                hintText: "Enter".tr +" "+"Option no".tr+ ' ${index + 1}',
                onChanged: (value){
                  controller.choices.value[index].text =value;
                },
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                   // Text("Correct",style: TextStyle(fontSize: 7),),
                Radio(
                  value: index,
                  groupValue:  controller.correctOption.value,
                  onChanged: (value) {
                    controller.correctOption.value = value as int;
                    for(var choice in controller.choices.value)
                      {
                        if(choice == controller.choices.value[index] )
                          {
                          choice.isCorrect =true;
                          }
                        else{
                          choice.isCorrect=false;
                        }
                        print("${choice.isCorrect!}");
                      }
                  },
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return kMainColor;
                    }
                    return Colors.grey;
                  })

                )
                //    Checkbox(
                //     value: controller.choices.value[index].isCorrect,
                //     fillColor: MaterialStateProperty.resolveWith((states) {
                //       if (states.contains(MaterialState.selected)) {
                //         return kMainColor;
                //       }
                //       return Colors.grey;
                //     }),
                //     onChanged:(value)
                //     {
                //       controller.choices.value[index].isCorrect = !controller.choices.value[index].isCorrect!;
                //       controller.choices.refresh();
                //       print("**************${ controller.choices[index].isCorrect!}");
                //     }
                // )
              ],
            ),
          );

        }
      )

        ],
      )
    );
  }

  Widget _buildTrueOrFalseQuestion(final size)
  {
    return     Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ...List.generate(2, (index){
              return ListTile(
                title: Container(
                  width: size.width *.6,
                  child:Text(index ==0 ?"True":"false")
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text("Correct",style: TextStyle(fontSize: 7),),
                    Radio(
                        value: index,
                        groupValue:  controller.correctOption.value,
                        onChanged: (value) {
                          controller.correctOption.value = value as int;
                          for(var choice in controller.choices.value)
                          {
                            if(choice == controller.choices.value[index] )
                            {
                              choice.isCorrect =true;
                            }
                            else{
                              choice.isCorrect=false;
                            }
                            print("${choice.isCorrect!}");
                          }
                        },
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return kMainColor;
                          }
                          return Colors.grey;
                        })

                    )
                    //    Checkbox(
                    //     value: controller.choices.value[index].isCorrect,
                    //     fillColor: MaterialStateProperty.resolveWith((states) {
                    //       if (states.contains(MaterialState.selected)) {
                    //         return kMainColor;
                    //       }
                    //       return Colors.grey;
                    //     }),
                    //     onChanged:(value)
                    //     {
                    //       controller.choices.value[index].isCorrect = !controller.choices.value[index].isCorrect!;
                    //       controller.choices.refresh();
                    //       print("**************${ controller.choices[index].isCorrect!}");
                    //     }
                    // )
                  ],
                ),
              );

            }
            )

          ],
        )
    );
  }


}
