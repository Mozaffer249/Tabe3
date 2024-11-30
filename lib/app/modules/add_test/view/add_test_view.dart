import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/common/multi_select_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/add_test/controller/add_test_controller.dart';

class AddTestView extends GetView<AddTestController> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
                () =>
                    LoadingOverlay(
            isLoading: controller.isLoading,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    BasicAppBar(title: 'Add test'.tr,),
                    Padding(
                      padding:  EdgeInsets.all(12),
                      child: BasicTextField(
                        controller: controller.classes,
                        readOnly: true,
                        hintText: 'Select classes'.tr,
                        labelText: 'Select classes'.tr,
                        onTap: () async {
                          final result =
                          await showDialog<List<ClassModel>>(
                            context: context,
                            builder: (context) {
                              return CustomMultiselectDropDown<
                                  ClassModel>(
                                title: 'Select classes'.tr,
                                items: controller.authController.availableClasses,
                                selectedItems: controller.selected,
                                onChanged: (List<ClassModel> values) {
                                  controller.selected = values;
                                },
                                builder: (context, index) => Text('${controller.authController.availableClasses.elementAt(index).name}',
                                ),
                              );
                            },
                          );
                          if (result != null) {
                            controller.selected = result;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      direction: Axis.horizontal,
                      children: controller.selected
                          .map((e) => Container(
                        child: Chip(
                          backgroundColor: kMainColor,
                          label: Text(
                            '${e.name}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding:  EdgeInsets.only(right: size.width*.03 ,left: size.width*.03),
                      child: BasicTextField(
                        controller: controller.testNameController,
                        hintText: 'Test name'.tr,
                        labelText: 'Test name'.tr,
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding:  EdgeInsets.only(right: size.width*.03 ,left: size.width*.03),
                      child: BasicTextField(
                        controller: controller.dateController,
                        hintText: 'Test date'.tr,
                        labelText: 'Test date'.tr,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please pick test date".tr;
                          }
                          return null;
                        },
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate,
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 1),
                            locale: Get.locale!,
                          );
                          if (date != null) {
                            controller.selectedDate = date;
                            controller.dateController.text = DateFormat(
                                'yyyy MMM, dd',
                                Get.locale!.languageCode)
                                .format(date);
                          }
                        },
                      ),
                    ),

                    Padding(
                      padding:   EdgeInsets.only(top: size.height*.04,right: size.width*.03 ,left: size.width*.03),
                      child: BasicButton(
                        onPresed: ()=>controller.addTest(),
                        label:'Add test'.tr ,

                      ),
                    )
                  ]
              ),
            )
        )
        )
    );
  }
}
