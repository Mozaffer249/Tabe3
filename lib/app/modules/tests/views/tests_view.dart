import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/Tests.dart';
import 'package:tabee3_flutter/app/data/models/attendance_report_model.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/tests/controllers/tests_controller.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class TestView extends GetView<TestsController> {
  @override
  Widget build(BuildContext context) {
    return  Obx(
      () => LoadingOverlay(
        isLoading: controller.isReLoading,
        child: Scaffold(
          body:Column(
            children: [
              BasicAppBar(title: 'Tests'.tr),

              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add test'.tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Spacer(),
                        BasicButton(
                          onPresed: () async {
                            final result = await Get.toNamed(Routes.ADD_TEST);
                            if (result != null) {
                              // controller.getAllTests();
                            }
                          },
                          label: Icon(

                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                    BasicDropdown<ClassModel>(
                      items: controller.authController.availableClasses,
                      value: controller.selectedClass,
                      onChanged: (ClassModel? value) {
                        controller.selectedClass = value;
                      },
                      builder: (ClassModel value) => Text(value.name!),
                    ),
                    if (controller.isLoading)
                      Container(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (controller.tests.value.isEmpty)
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
                      ListView.separated(
                        itemCount: controller.tests.value.length,
                        shrinkWrap: true,
                        primary: false,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          final test = controller.tests.value.elementAt(index);
                           return _buildTestCard(test);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 16),
                      ),
                  ],
                ),
              ))
            ],
          ) ,
        ),
    ));
  }


  Card _buildTestCard(Tests test) {
    return Card(
      child: InkWell(
        onTap: () async {
          final result = await Get.toNamed(Routes.TEST_QUESTIONS, arguments: test);
          if (result != null && result) {
            controller.getAllTests();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              test.name!  ,
              style: Get.theme.textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Date:'.tr,

                  ),
                  SizedBox(width: 8),
                  Text(
                    // DateFormat(
                    //     'yyyy MMM, dd',
                    //     Get.locale!.languageCode)
                    //     .format(date),
                    "${test.date}",
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Total questions:'.tr,

                  ),
                  SizedBox(width: 8),
                  Text(
                    "{numQuestions}",

                  ),
                ],
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

}