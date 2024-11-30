// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/teacher_exam.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/exam_provider.dart';
import 'package:tabee3_flutter/app/utils/extensions.dart';

class EditExamsScheduleController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _exams = <GeneralExam>[].obs;
  List<GeneralExam> get exams => _exams.value;

  final _filteredExams = <GeneralExam>[].obs;
  List<GeneralExam> get filteredExams => _filteredExams.value;

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) {
    _selectedDate(value);
    _filteredExams.value = _exams.value
        .where((element) => element.date!.isSameDate(value))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    getExams();
  }

  Future<void> getExams() async {
    _isLoading(true);
    final result =
        await ExamProvider.getTeacherExams(authController.currentUser!.id!);
    _isLoading(false);
    result.fold(
      (l) {
        _exams(l);
        _filteredExams(l);
      },
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
