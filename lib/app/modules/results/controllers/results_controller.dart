// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';

class ResultsController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final Rxn<ClassModel> _selectedClass = Rxn<ClassModel>();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? value) {
    _selectedClass(value);
    getStudentsInClass();
  }

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  final RxList<Student> _students = <Student>[].obs;
  List<Student> get students => _students.value;

  late Subject subject;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      subject = Get.arguments as Subject;
    }
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass.value = authController.availableClasses.first;
      getStudentsInClass();
    }
  }

  Future<void> getStudentsInClass() async {
    _isLoading(true);
    final result =
        await StudentsProvider.getStudentsInClass(_selectedClass.value!.id!);
    _isLoading(false);
    result.fold(
      (l) => _students(l),
      (r) => null,
    );
  }

  @override
  void onClose() {}
}
