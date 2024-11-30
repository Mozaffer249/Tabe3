// ignore_for_file: invalid_use_of_protected_member

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/attendance_report_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/attendance_provider.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';

class ViewAttendanceController extends GetxController {
  final _authController = Get.find<AuthController>();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final RxList<AttendanceReport> _attendanceReport = <AttendanceReport>[].obs;
  List<AttendanceReport> get attendanceReport => _attendanceReport.value;

  @override
  void onInit() {
    super.onInit();
    getReports();
  }

  Future<void> getReports() async {
    _isLoading(true);
    final Either<List<AttendanceReport>, String> result =
        await AttendanceProivder.getAttendanceReport(
            _authController.currentUser!.id!);
    result.fold(
      (List<AttendanceReport> l) {
        _attendanceReport(l);
      },
      (String r) => showSnackbar(title: 'Error'.tr, message: r),
    );
    _isLoading(false);
  }

  @override
  void onClose() {}
}
