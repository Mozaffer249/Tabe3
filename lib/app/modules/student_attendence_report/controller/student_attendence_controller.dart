import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tabee3_flutter/app/data/models/studnet_attendance_model.dart';
import 'package:tabee3_flutter/app/providers/attendance_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class StudentAttendenceCotroller extends GetxController{

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final _isSubmitting = false.obs;
  bool get isSubmitting => _isSubmitting.value;

  final Rx<DateTime> _selectedStartDate = DateTime.now().obs;
  DateTime get selectedStartDate => _selectedStartDate.value;
  set selectedStartDate(DateTime dateTime) {
    _selectedStartDate(dateTime);
    // getStudents();
  }

  final Rx<DateTime> _selectedEndDate = DateTime.now().obs;
  DateTime get selectedEndDate => _selectedEndDate.value;
  set selectedEndDate(DateTime dateTime) {
    _selectedEndDate(dateTime);
    getStudnetAttndenceRecord();
  }
  final RxList<StudentAttendance> _studnets = <StudentAttendance>[].obs;
  List<StudentAttendance> get studnets => this._studnets.value;

  final RxList<StudentAttendance> _filteredStudnets = <StudentAttendance>[].obs;
  List<StudentAttendance> get filteredStudnets => this._filteredStudnets.value;

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
      _filteredStudnets.value =
          _studnets.value.where((element) => !element.present!).toList();
    } else if (value == 'By present'.tr) {
      _filteredStudnets.value =
          _studnets.value.where((element) => element.present!).toList();
    } else {
      _filteredStudnets.value = _studnets.value;
    }
    _filteredStudnets.refresh();
  }

  late final int studentId;
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null)studentId=Get.arguments;
  }

  Future<void> getStudnetAttndenceRecord() async {
    _isSubmitting(true);
    final request = <String, dynamic>{
      "student_id": studentId,
      "date_from":DateFormat('MM/dd/yyyy').format(selectedStartDate)  ,
      "date_to":DateFormat('MM/dd/yyyy').format(selectedEndDate)
    };

    final result = await AttendanceProivder.getStudentAttendanceRecord(request);
    _isSubmitting(false);
    result.fold(
          (l) {
        _studnets(l['students']);
        _filteredStudnets(l['students']);

        _studnets.refresh();
        _filteredStudnets.refresh();

        _studnets.value.sort((a, b) => b.date!.compareTo(a.date!));
        _filteredStudnets.value.sort((a, b) => b.date!.compareTo(a.date!));


        print(_studnets.length);
      },
      (r) => print(r),
    );

  }


}