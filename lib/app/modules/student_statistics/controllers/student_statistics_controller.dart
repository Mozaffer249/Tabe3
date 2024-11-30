// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/student_result.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/result_provider.dart';

class StudentStatisticsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  set currentTab(int value) => _currentTab(value);

  final RxBool _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;

  final RxList<StudentResult> _results = <StudentResult>[].obs;
  List<StudentResult> get results => this._results.value;

  late Map<String, dynamic> request;
  late Student student;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      request = Get.arguments as Map<String, dynamic>;
      student = request['student'];
      request.removeWhere((key, value) => key == "student");
      getStudentResult();
    }
  }

  Future<void> getStudentResult() async {
    request['teacher_id'] = authController.currentUser!.id;
    _isLoading(true);
    final response = await ResultProvider.getStudentResult(request);
    _isLoading(false);
    response.fold(
      (l) => _results(l),
      (r) => null,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
