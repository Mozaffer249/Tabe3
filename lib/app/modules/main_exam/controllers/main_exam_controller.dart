import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/exams_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/exam_provider.dart';

class MainExamController extends GetxController {
  List exma = <ExamModel>[].obs;
  AuthController authController = Get.put(AuthController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getMainExams();
  }

  void getMainExams() async {
    int student_id = authController.currentUser!.id!;
    final result = await ExamProvider.getExams(student_id);

    result.fold(
      (l) {
        this.exma;
      },
      (String r) => null,
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
