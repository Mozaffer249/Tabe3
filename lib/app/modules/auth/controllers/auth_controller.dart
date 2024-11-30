// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
 import 'package:tabee3_flutter/app/controllers/settings_controller.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/data/models/user_model.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AuthController extends GetxController {


  Rxn<User> _currentUser = Rxn();
  User? get currentUser => _currentUser.value;
  set currentUser(User? user) => _currentUser.value = user;

  final _teacherSubjects = <Subject>[].obs;
  List<Subject> get teacherSubjects => _teacherSubjects;
  set teacherSubjects(List<Subject> classes) => _teacherSubjects(classes);

  final _availableClasses = <ClassModel>[].obs;
  List<ClassModel> get availableClasses => _availableClasses.value;
  set availableClasses(List<ClassModel> classes) => _availableClasses(classes);

  RxInt student_id = 0.obs;

  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  set isAuthenticated(bool val) => _isAuthenticated.value = val;

  var connectionType = 3.obs;


  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if(connectionType ==0 || connectionType == 3) {
      await Future.delayed(Duration(seconds: 2));
      final firstLaunch = CommonVariables.userData.read('firstLaunch') ?? true;
      if (firstLaunch) {
        Get.offAllNamed(Routes.START);
      } else {
        final isAuthed = CommonVariables.userData.read('isAuthed') ?? false;
        if (isAuthed) {
          final userData = CommonVariables.userData.read('userData');
          if (userData != null) {
            _currentUser.value = User.fromJson(userData as Map<String, dynamic>);
            _availableClasses.value = (CommonVariables.userData.read('available_class') as List)
                .map((e) => ClassModel.fromMap(json.decode(e))).toList();
            if (_currentUser.value!.userType == 'T') {
              List<dynamic>? classes =
              CommonVariables.userData.read('teacherClasses');
              if (classes != null && classes.isNotEmpty) {
                _teacherSubjects.value = classes.map((e) => Subject.fromMap(e)).toList();
              }
            }
            _isAuthenticated.value = true;
            Get.offAllNamed(Routes.HOME);
          } else {
            CommonVariables.userData.write('isAuthed', false);
            Get.offAllNamed(Routes.LOGIN);
          }
        } else {
          CommonVariables.userData.write('isAuthed', false);
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    } else{
    // await enternetConnectioDialog();

      await Future.delayed(Duration(hours: 24));
    }
  }

  Future<void> logout() async {
    Get.offAllNamed(Routes.SPLASH);
    CommonVariables.userData.remove('userData');
    CommonVariables.userData.remove('isAuthed');
    // _currentUser.value = null;
    _isAuthenticated(false);
    await init();
  }

  @override
  void onClose() {}
// Define User, Class, and Subject models

}
