import 'package:get/get.dart';
import 'package:tabee3_flutter/app/modules/student_attendence_report/controller/student_attendence_controller.dart';

class StudentAttendenceReportBinding extends Bindings
{
  @override
  void dependencies() {
  Get.put(StudentAttendenceCotroller());
  }

}