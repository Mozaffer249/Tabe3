import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/modules/add_behavior/controller/add_behavior_controller.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AddBehaviorView extends GetView<AddBehaviorController>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
            () => LoadingOverlay(
          isLoading: controller.isSubmitting,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: BasicAppBar(title: 'Add Behavior'.tr),
              ),
        Expanded(child: Stack(
          children: [
            Container(
              height:MediaQuery.of(Get.context!).size.height*.5 ,
              margin: EdgeInsets.all(15),
              child: Card(
                child: TextFormField(
                  controller: controller.bodyController,
                  maxLines: 20,
                  decoration: InputDecoration.collapsed(
                    hintText: "Behavior body".tr,
                    border: InputBorder.none,

                  ),
                ),
              ),
            ),
            SizedBox(height: 150,),
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: BasicButton(
                label: 'Send Behavior'.tr,
                onPresed: () async {

                  if (controller.bodyController.text.isEmpty) {
                    showSnackbar(
                      title: null,
                      message: 'Please fill Behavior body'.tr,
                      isError: true,
                    );
                    return;
                  }
                  for(var beh in controller.behaviorerIds)
                    {
                      controller.addBehavior(
                          student_Id: beh,
                          isLast: beh == controller.behaviorerIds.last ? true:false
                      );
                    }
                  //  Get.toNamed(Routes.ADDBEHAVIOR,arguments: [controller.behaviorerIds]);
                },
              ),
            ),
          ],
        ))

            ],
          ),
        ),
      ),
    );
  }
}