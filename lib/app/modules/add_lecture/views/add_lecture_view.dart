import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/common/constants.dart';
import 'package:tabee3_flutter/app/data/common/multi_select_dropdown.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/utils/GoogleDrive/secureStorge.dart';
 import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';

import '../controllers/add_lecture_controller.dart';

class AddLectureView extends GetView<AddLectureController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isLoading,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: BasicAppBar(title: 'Add new lecture'.tr),
              ),
              SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BasicDropdown<ClassModel>(
                        //   items: controller.authController.availableClasses,
                        //   value: controller.selectedClass,
                        //   onChanged: (ClassModel? value) {
                        //     controller.selectedClass = value;
                        //   },
                        //   builder: (ClassModel value) => Text(value.name!),
                        //   validator: (ClassModel? value) {
                        //     if (value == null) {
                        //       return "Please select class".tr;
                        //     }
                        //
                        //     return null;
                        //   },
                        // ),
                        BasicTextField(
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
                        BasicTextField(
                          controller: controller.lectureNameController,
                          hintText: 'Lecture name'.tr,
                          labelText: 'Lecture name'.tr,
                        ),
                        SizedBox(height: 16),
                        BasicTextField(
                          controller: controller.subjectNameController,
                          hintText: 'Subject name'.tr,
                          readOnly: true,
                          labelText: 'Subject name'.tr,
                        ),

                        BasicDropdown<ClassModel>(
                          items: controller.lecturesTypes,
                          value: controller.selecteLectureType,
                          onChanged: (ClassModel? value) {
                            controller.selecteLectureType = value;
                          },
                          builder: (ClassModel value) => Text(value.name!),
                        ),
                        SizedBox(height: 16),
                        if(controller.selecteLectureType?.id == 2)
                        BasicTextField(
                          controller: controller.fileNameController,
                          hintText: 'Choose Lecture From Files'.tr,
                          labelText: 'Lecture'.tr,
                        //  keyboardType: TextInputType.url,
                          readOnly: true,
                          onTap: (){
                            controller.uploadFile();
                            },
                        )
                        else
                        BasicTextField(
                          controller: controller.liveLectureLinkController,
                          hintText: 'Lecture link'.tr,
                          labelText: 'Lecture link'.tr,
                          keyboardType: TextInputType.url,
                        ),
                        SizedBox(height: 40),
                        // BasicTextField(
                        //   controller: controller.driverLinkController,
                        //   hintText: 'Lecture drive link'.tr,
                        //   labelText: 'Lecture drive link'.tr,
                        //   keyboardType: TextInputType.url,
                        // ),
                        // SizedBox(height: 40),
                        BasicButton(
                          label: 'Save'.tr,
                          onPresed:()async{

                            controller.uploadToDrive();
                            // SecureStorage v=SecureStorage();
                            // v.clear();
                            // print("************************${id}");
                            //
                            // for(var selectedClass in controller.selected)
                            // controller.submit(
                            //     classId: selectedClass.id!,
                            //     isLast:selectedClass.id! == controller.selected.last.id?true:false
                            // );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
