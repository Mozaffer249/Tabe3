import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class SignUpController extends GetxController {
  var authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController healthStatusController = TextEditingController();

  final Rxn<ClassModel> _selectedClass = Rxn<ClassModel>();
  ClassModel? get selectedClass => this._selectedClass.value;
  set selectedClass(value) => this._selectedClass.value = value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;

  @override
  void onInit() {
    super.onInit();
  }

  void signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final request = {
      "name": nameController.text.trim(),
      "class_id": selectedClass!.id,
      "age": ageController.text.trim(),
      "health_condition": healthStatusController.text.trim(),
    };
    _isLoading(true);
    final Either<bool, String> result =
        await StudentsProvider.addNewStudent(request);
    _isLoading(false);
    result.fold(
      (bool l) async {
        Get.back();
        await showSnackbar(
          title: 'Success'.tr,
          message: 'Student registered'.tr,
        );
      },
      (String r) => showSnackbar(
        title: 'Error'.tr,
        message: 'Somthing went wrong'.tr,
      ),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
