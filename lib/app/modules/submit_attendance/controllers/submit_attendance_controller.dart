// ignore_for_file: invalid_use_of_protected_member

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/ViewModel/student_parent_view_model.dart';
import 'package:tabee3_flutter/app/data/models/attendance_report_model.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/student_model.dart';
import 'package:tabee3_flutter/app/data/models/studnet_attendance_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:tabee3_flutter/app/providers/attendance_provider.dart';
import 'package:tabee3_flutter/app/providers/student_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class SubmitAttendanceController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final _isSubmiting = false.obs;
  get isSubmiting => this._isSubmiting.value;

  final RxList<StudentAttendance> _studnets = <StudentAttendance>[].obs;
  List<StudentAttendance> get studnets => this._studnets.value;

  final RxList<StudentAttendance> _filteredStudnets = <StudentAttendance>[].obs;
  List<StudentAttendance> get filteredStudnets => this._filteredStudnets.value;

  final _studentList = <Student>[].obs;
  List<Student> get studentslist => _studentList.value;

  final _filteredstudentList = <Student>[].obs;
  List<Student> get filteredstudentslist => _filteredstudentList.value;

  final _absanceIds = <int>[].obs;
  List<int> get absanceIds => _absanceIds.value;

  final Rxn<ClassModel> _selectedClass = Rxn<ClassModel>();
  ClassModel? get selectedClass => _selectedClass.value;

  final List<String> filterBy = [
    'All'.tr,
    'By absence'.tr,
    'By present'.tr,
  ];

  final RxString _selectedFilter = ''.obs;
  String get selectedFilter => this._selectedFilter.value;

  set selectedFilter(String value) {
    _selectedFilter.value = value;

    if (value == 'By absence'.tr) {
      _filteredstudentList.value =
          _studentList.value.where((element) => element.isAbsent).toList();
    } else if (value == 'By present'.tr) {
      _filteredstudentList.value =
          _studentList.value.where((element) => !element.isAbsent).toList();
    } else {
      _filteredstudentList.value = _studentList.value;
    }
    _filteredstudentList.refresh();
  }

  late AttendanceReport report;

  RxBool _isAttendenceConfirmed =false.obs;
  RxBool get isAttendenceConfirmed => _isAttendenceConfirmed;

  final  _studentsParent = <StudentParentModel>[].obs;
  RxList<StudentParentModel> get students => _studentsParent;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      _selectedFilter.value = filterBy.first;
      _selectedClass.value = authController.availableClasses.first;

      report = Get.arguments as AttendanceReport;
      getParents();

    }
  }

  Future<void> getStudnets() async {
    _isLoading(true);
    final result = await AttendanceProivder.getStudentAttendance(report.id!);
    _isLoading(false);
    result.fold(
      (l) {
        _studnets(l['attendance']);
        _filteredStudnets(l['attendance']);
        report = l['report'];
        _isAttendenceConfirmed.value=l['aprroved'];

        for(int i = 0; i < _studnets.length; i++){
          _studentList.value.add(
            Student(
              studentId: _studnets[i].studentId,
              isAbsent: !_studnets[i].present!,
              studentName: _studnets[i].name,
              absentReason: "${_studnets[i].absentReason}",
              parentPhone: _studentsParent[i].mobile == false ||_studentsParent[i].mobile is bool || _studentsParent[i].mobile ==null  ? "":_studentsParent[i].mobile
            )
          );
          print("************************Stu${_studentList.length}");

          _filteredstudentList.value.add(
            Student(
              studentId: _studnets[i].studentId,
              isAbsent: !_studnets[i].present!,
              studentName: _studnets[i].name,
              absentReason: "${_studnets[i].absentReason}",
              parentMobile: _studentsParent[i].mobile == false ||_studentsParent[i].mobile is bool || _studentsParent[i].mobile ==null  ? "":_studentsParent[i].mobile,
              parentPhone: _studentsParent[i].phone == false ||_studentsParent[i].phone is bool || _studentsParent[i].phone ==null  ? "":_studentsParent[i].phone

            )
          );

        }
      },
      (r) => showSnackbar(title: 'Error'.tr, message: r.substring(0,30)),
    );

  }

  Future<void> getParents() async {
    _isLoading(true);
    final result = await StudentsProvider.getClassStudentWithParent(_selectedClass.value!.id!);
    result.fold(
          (l) {
            _studentsParent(l);
            getStudnets();
          } ,
          (r) => null,
    );

    print("************************Parent${_studentsParent.length}");

  }
  Future<void> updateAttendnance() async {
    if(isAttendenceConfirmed.value){
      showSnackbar(title: 'Error'.tr, message: "Confirmed");
    }
    else{
      _isSubmiting(true);
      final request = <String, dynamic>{
        "attendance_id": report.id,
        "students_obj": _filteredstudentList.map((e) =>
        {
          "id": e.studentId,
          "is_absent": e.isAbsent,
          "is_present": !e.isAbsent,
          "absent_reason":e.absentReason
        }).toList(),
      };

      final result = await AttendanceProivder.updateAttendence(request);
      _isSubmiting(false);
      result.fold(
            (l) {
          submitAttendnance();
        } ,
            (r) => showSnackbar(title: 'Error'.tr, message: r),
      );
    }

  }
  Future<void> submitAttendnance() async {
    _isSubmiting(true);
    final result =
        await AttendanceProivder.confirmStudentAttendance(report.id!);
    _isSubmiting(false);
    result.fold(
      (l) => Get.back(result: true),
      (r) => showSnackbar(title: 'Error'.tr, message: r),
    );
  }

  // Future<void> submit() async {
  //   final request = <String, dynamic>{
  //     "students_obj": students
  //         .map((e) => {
  //       "id": e.studentId,
  //       "is_absent": e.isAbsent,
  //       "is_present": !e.isAbsent
  //     })
  //         .toList(),
  //     "subject_id": subject.id,
  //     "class_id": selectedClass!.id,
  //     "teacher_id": authController.currentUser!.id,
  //     "date": DateFormat('MM/dd/yyyy').format(selectedDate),
  //   };
  //   _isSubmitting(true);
  //   final result = await AttendanceProivder.submitAttendance(request);
  //   _isSubmitting(false);
  //   result.fold((l) {
  //     showSnackbar(
  //       title: null,
  //       message: 'Attendance created successfully'.tr,
  //       isError: false,
  //     );
  //     absanceIds.clear();
  //   },
  //           (r) => showSnackbar(
  //         title: 'Error'.tr,
  //         message: r,
  //         isError: true,
  //       ));
  // }

  void toggelAbsance(int index, bool? value) {
    _filteredstudentList.value[index].isAbsent = !_filteredstudentList.value[index].isAbsent ;
    if(!value!)_filteredstudentList.value[index].absentReason="";
    print(_filteredstudentList.value[index].absentReason);
    _filteredstudentList.refresh();

  }

  @override
  void onClose() {}
}
