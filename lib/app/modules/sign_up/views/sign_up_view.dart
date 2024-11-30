import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabee3_flutter/app/data/common/basic_AppBar.dart';
import 'package:tabee3_flutter/app/data/common/basic_button.dart';
import 'package:tabee3_flutter/app/data/common/basic_dropdown.dart';
import 'package:tabee3_flutter/app/data/common/basic_textfield.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: "newStudent"),
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 24,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 41.0,
                      bottom: 9.0,
                    ),
                    child: Text(
                      'newStudent'.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF363636),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BasicTextField(
                    controller: controller.nameController,
                    hintText: 'fullName'.tr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'fullName'.tr + 'required'.tr;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 14.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'studyYear'.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF363636),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BasicDropdown<ClassModel>(
                    items: controller.authController.availableClasses,
                    onChanged: (ClassModel? value) {
                      controller.selectedClass = value;
                    },
                    hintText: 'chooseYear'.tr,
                    value: controller.selectedClass,
                    validator: (value) {
                      if (value == null) {
                        return 'studyYear'.tr + 'required'.tr;
                      }
                      return null;
                    },
                    builder: (item) {
                      return Text('${item.name}');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 14.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'age'.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF363636),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BasicTextField(
                    controller: controller.ageController,
                    hintText: 'age'.tr,
                    validator: (value) {
                      if (value == null) {
                        return 'age'.tr + 'required'.tr;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 14.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'healthStatus'.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF363636),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BasicTextField(
                    controller: controller.healthStatusController,
                    hintText: 'healthStatus'.tr,
                    validator: (value) {
                      if (value == null) {
                        return 'healthStatus'.tr + 'required'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  BasicButton(
                    label: 'signUp'.tr,
                    onPresed: controller.signUp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
