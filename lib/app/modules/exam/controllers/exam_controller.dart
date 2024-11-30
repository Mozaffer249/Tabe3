import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/result_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/result_provider.dart';

class ExamController extends GetxController {
  List result = <Result>[].obs;
  AuthController authController = Get.put(AuthController());
  RxString? exam_val = "اختار المادة,".obs;
  final count = 0.obs;


  @override
  void onInit() {
    super.onInit();
    getResult();
  }

  void getResult() async {
    int student_id = authController.currentUser!.id!;
    int exam_id = authController.currentUser!.id!;
    final result = await ResultProvider.getResult(student_id, exam_id);
    result.fold(
      (l) {
        this.result;
      },
      (String r) => null,
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
