import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';

class AllSubjectsController extends GetxController {
  late List<Subject> subjects;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      subjects = Get.arguments;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
