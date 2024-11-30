import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/data/models/user_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/user_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final count = 0.obs;

  TextEditingController mobileConrtoller = TextEditingController();
  TextEditingController passwordConrtoller = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> formKey = GlobalKey();

  final _showPassword = false.obs;
  get showPassword => this._showPassword.value;
  set showPassword(value) => this._showPassword.value = value;

  @override
  void onInit() {
   // mobileConrtoller.text = '249123456777';
     mobileConrtoller.text = '24995090099';
    passwordConrtoller.text = '1234';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _isLoading(true);
    final result = await UserProvider.login(
        mobileConrtoller.text.trim(), passwordConrtoller.text.trim());
    // final result = await getDataAsJson();
    _isLoading(false);
    result.fold(
      (left)  {
        authController.currentUser = left!['user'] as User;
        authController.isAuthenticated = true;
        authController.availableClasses = left['available_class'];
        if(authController.availableClasses.isEmpty){
          print("no classes found");
          return;
        }
        // updateToken();
        CommonVariables.userData.write('isAuthed', true);
        CommonVariables.userData.write('available_class', authController.availableClasses);
        CommonVariables.userData.write('userData', authController.currentUser!.toJson());

        if (authController.currentUser!.userType == 'T') {
          CommonVariables.userData.write('teacherClasses', left['teacher_subjects']);
          authController.teacherSubjects = (left['teacher_subjects'] as List)
              .map((e) => Subject.fromMap(e))
              .toList();
        }
        Get.offAllNamed(Routes.HOME);
      },
      (right) {
        log(right!);
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: '$right',
        ));
      },
    );
  }
  Future<void> updateToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await UserProvider.updateToken(authController.currentUser!.id!, token);
  }
// Function to get user data, classes list, and subjects list
 Future<Either< Map<String, dynamic>, String>> getDataAsJson() async{
    // Example user data
    User user = User(
      id: 1,
      companyId: 101,
      name: "John Doe",
      verify: "Verified",
      mobile: "1234567890",
      countryId: "US",
      countryName: "United States",
      cityId: "NYC",
      cityName: "New York",
      userType: "T",
      schoolName: "Greenwood High",
      image: "https://example.com/profile.jpg",
      attendanceAdmin: true,
    );

    // Example classes list
    List<ClassModel> classes = [
      ClassModel(id: 1, name: "Math 101"),
      ClassModel(id: 2, name: "Science 101"),
      ClassModel(id: 3, name: "History 101"),
    ];

    // Example subjects list
    List<Subject> subjects = [
      Subject(id: 1, name: "Mathematics", image: "https://example.com/math.jpg"),
      Subject(id: 2, name: "Science", image: "https://example.com/science.jpg"),
      Subject(id: 3, name: "History", image: "https://example.com/history.jpg"),
    ];

  await  Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> returnedResponse = {};

    returnedResponse['user'] = user ;
    returnedResponse['available_class'] = classes ;
    returnedResponse['teacher_subjects'] = subjects  ;

    print(returnedResponse["user"].id);

    // Construct JSON as a Map
    return left(returnedResponse);
  }
}
