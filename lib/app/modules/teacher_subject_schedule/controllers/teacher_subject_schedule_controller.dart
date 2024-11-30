// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/teacher_subject.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/lecture_provider.dart';

class TeacherSubjectScheduleController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxMap<String, List<TeacherSubject>> _lectures =
      <String, List<TeacherSubject>>{}.obs;
  Map<String, List<TeacherSubject>> get lectures => _lectures.value;

  final RxList<String> _days = <String>[].obs;
  List<String> get days => _days.value;

  final AuthController authController = Get.find<AuthController>();

  final RxString selectedDay = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLectures();
  }

  Future<void> getLectures() async {
    _isLoading(true);
    final result = await LectureProvider.getTimeTableTeahcer(
        authController.currentUser!.id!);
    _isLoading(false);
    result.fold(
      (l) {
        if (l.isNotEmpty) {
          _lectures.value = groupBy(l, ((p0) => p0.dayOfWeek!));
          _lectures.values.forEach((element) {
            element.sort((a, b) => a.index!.compareTo(b.index!));
          });
          _lectures.refresh();
          _days.value = _lectures.keys.toList();
          selectedDay.value = _days.first;
        }
      },
      (r) => log('$r'),
    );
  }

  @override
  void onClose() {}
}
