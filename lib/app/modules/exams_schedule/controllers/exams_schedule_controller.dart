// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/teacher_exam.dart';
import 'package:tabee3_flutter/app/providers/exam_provider.dart';
import 'package:tabee3_flutter/app/utils/extensions.dart';

class ExamsScheduleController extends GetxController {
  late Student student;

  final RxList<GeneralExam> _exams = <GeneralExam>[].obs;
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

  final RxBool _isLoading = false.obs;
  bool get isLoading => this._isLoading.value;

  @override
  void onInit() {
    super.onInit();
    student = Get.arguments;
    getExams();
  }

  Future<void> getExams() async {
    _isLoading(true);
    final result = await ExamProvider.getStudentExams(student.studentId!);
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
  void onClose() {}
}
