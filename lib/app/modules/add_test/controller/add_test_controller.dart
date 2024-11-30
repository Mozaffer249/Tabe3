import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/Tests.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/modules/tests/controllers/tests_controller.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AddTestController extends GetxController{

  final AuthController authController = Get.find<AuthController>();
  final TestsController testController = Get.find<TestsController>();

  final TextEditingController testNameController = TextEditingController();
  final TextEditingController classes = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final RxList<ClassModel> _selected = <ClassModel>[].obs;
  List<ClassModel> get selected => this._selected.value;
  set selected(value) {this._selected.value = value;_selected.refresh();}

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime model) => _selectedDate(model);

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addTest(){
    if (_selected.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please pick classes'.tr,
        isError: true,
      );
      return;
    }
    if (testNameController.text.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please insert name'.tr,
        isError: true,
      );
      return;
    }
    if (testNameController.text.isEmpty) {
      showSnackbar(
        title: null,
        message: 'Please insert name'.tr,
        isError: true,
      );
      return;
    }
    Random random = new Random();

    Tests test =Tests(
      id:random.nextInt(1000)  ,
      name:testNameController.text ,
      date: _selectedDate.toString(),
      classessNames: _selected.map((element) => element.name!).toList(),
    );
    testController.tests.add(test);
    testController.tests.refresh();
    Get.back(result: true);
    // testController.tests.;


  }
}