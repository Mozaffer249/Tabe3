// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/attendance_provider.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class AttencanceController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isSubmitting = false.obs;
  bool get isSubmitting => _isSubmitting.value;

  final _students = <Student>[].obs;
  List<Student> get students => _students.value;

  final _absanceIds = <int>[].obs;
  List<int> get absanceIds => _absanceIds.value;

  final _filteredStudents = <Student>[].obs;
  List<Student> get filteredStudents => _filteredStudents.value;

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime dateTime) {
    _selectedDate(dateTime);
  // getStudents();
  }

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) {
    _selectedClass(model);
    getStudents();
  }

  late Subject subject;

  @override
  void onInit() {
    super.onInit();
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass.value = authController.availableClasses.first;
      print(_selectedClass.value!.name);
    }
    if (Get.arguments != null) {
      subject = Get.arguments;
    }
    getStudents();
  }

  void filter(String keyword) {
    _filteredStudents.value = _students
        .where((element) => element.studentName!.contains(keyword))
        .toList();
  }

  Future<void> getStudents() async {
    _filteredStudents.clear();
    _students.clear();
    _isLoading(true);
    final result =
        await StudentsProvider.getStudentsInClass(selectedClass!.id!);
    _isLoading(false);
    result.fold(
      (l) {
        _students(l);
        _filteredStudents(l);
      },
      (r) => showSnackbar(
        title: 'Error'.tr,
        message: r,
        isError: true,
      ),
    );
  }

  Future<void> submit() async {
    final request = <String, dynamic>{
      "students_obj": students
          .map((e) => {
                "id": e.studentId,
                "is_absent": e.isAbsent,
                "is_present": !e.isAbsent
              })
          .toList(),
      "subject_id": subject.id,
      "class_id": selectedClass!.id,
      "teacher_id": authController.currentUser!.id,
      "date": DateFormat('MM/dd/yyyy').format(selectedDate),
    };
    _isSubmitting(true);
    final result = await AttendanceProivder.submitAttendance(request);
    _isSubmitting(false);
    result.fold((l) {
      showSnackbar(
        title: null,
        message: 'Attendance created successfully'.tr,
        isError: false,
      );
      absanceIds.clear();
    },
        (r) => showSnackbar(
              title: 'Error'.tr,
              message: r,
              isError: true,
            ));
  }

  void toggelAbsance(int id, bool? value) {
    final index = _students.value.indexWhere((element) => element.studentId == id);

    if (index != -1) {
      _students.value[index].isAbsent = !_students.value[index].isAbsent;
      if (value != null && value) {
        _absanceIds.value.add(id);
      } else {
        _absanceIds.value.remove(id);
      }
      _students.refresh();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
