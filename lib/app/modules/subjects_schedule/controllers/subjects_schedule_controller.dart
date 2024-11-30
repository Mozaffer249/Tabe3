// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/lecture_model.dart';
import 'package:tabee3_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:tabee3_flutter/app/providers/lecture_provider.dart';

class SubjectsScheduleController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxMap<String, List<LectureModel>> _lectures =
      <String, List<LectureModel>>{}.obs;
  Map<String, List<LectureModel>> get lectures => _lectures.value;

  final RxList<String> _days = <String>[].obs;
  List<String> get days => _days.value;

  final HomeController homeController = Get.find<HomeController>();

  final RxString selectedDay = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLectures();
  }

  Future<void> getLectures() async {
    _isLoading(true);
    final Either<Map<String, dynamic>?, String> result =
        await LectureProvider.getLectures(
            homeController.student.value!.studentId!);
    _isLoading(false);
    result.fold(
      (l) {
        _lectures.value = l!.map(
          (key, value) => MapEntry(key.substring(0, 3).capitalize!,
              (value as List).map((e) => LectureModel.fromJson(e)).toList()),
        );
        log('${_lectures.value}');
        _lectures.values.forEach((element) {
          element.sort((a, b) => a.index!.compareTo(b.index!));
        });
        _lectures.refresh();
        _days.value = _lectures.keys.toList();
        _days.value =
            _days.value.map((e) => e.substring(0, 3).capitalize!).toList();
        selectedDay.value = _days.first;
      },
      (r) => log('$r'),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
