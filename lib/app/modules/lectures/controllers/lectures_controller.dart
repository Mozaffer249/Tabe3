// ignore_for_file: invalid_use_of_protected_member
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tabee3_flutter/app/data/models/class_model.dart';
import 'package:tabee3_flutter/app/data/models/lesson_model.dart';
import 'package:tabee3_flutter/app/data/models/subject_model.dart';
import 'package:tabee3_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:tabee3_flutter/app/providers/lesson_provider.dart';
import 'package:tabee3_flutter/app/routes/app_pages.dart';
import 'package:tabee3_flutter/app/utils/dialog_utils.dart';
import 'package:tabee3_flutter/app/utils/file_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LecturesController extends GetxController {
  late Subject subject;
  RxString Rxlesson="".obs;
  final AuthController _authController = Get.find<AuthController>();
  final AuthController authController = Get.find<AuthController>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isDeleting = false.obs;
  bool get isDeleting => _isDeleting.value;

  final RxList<Lesson> _lessons = <Lesson>[].obs;
  List<Lesson> get lessons => _lessons.value;

  final Rxn<ClassModel> _selectedClass = Rxn();
  ClassModel? get selectedClass => _selectedClass.value;
  set selectedClass(ClassModel? model) {
    _selectedClass(model);
    getLessons();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      subject = Get.arguments;
    } else {
      Get.back();
    }
    if (authController.availableClasses.isNotEmpty) {
      _selectedClass.value = authController.availableClasses.first;
    }
    getLessons();
  }

  Future<void> getLessons() async {
    _isLoading(true);
    final result = await LessonProvider.getLessons(subject.id!,selectedClass!.id!);
    _isLoading(false);
    result.fold(
      (l) => _lessons(l),
      (r) => null,
    );
  }

  Future<void> deleteLesson(int id) async {
    final Map<String, dynamic> request = {
      "id": id,
      "teacher_id": _authController.currentUser!.id,
    };
    _isDeleting(true);
    final result = await LessonProvider.deleteLesson(request);
    _isDeleting(false);
    result.fold(
      (l) => getLessons(),
      (r) => showSnackbar(title: 'Error'.tr, message: r),
    );
  }

  Future<void> ViewLesson(Lesson lesson)async
  {
    print("************************${lesson.url}");
    if (lesson.url != null && lesson.url!.isNotEmpty ) {
      if (await canLaunchUrlString(lesson.url!))
      {await launch(lesson.url! );}
      else {
        showSnackbar(
          title: 'Error'.tr,
          message: 'Cannot open link for this lesson'.tr,);
      }
    }
    // else if(lesson.lesson! !=null ){
    //   final lessonExtention=await getBase64FileExtension(lesson.lesson!);
    //   if(lessonExtention=="pdf")
    //     {
    //       print("pdf");
    //       Get.toNamed(
    //           Routes.LECTURE_DETAILS,
    //           arguments: [lesson,"pdf"]
    //       );
    //     }
    //   else{
    //     print("image");
    //     Get.toNamed(
    //         Routes.LECTURE_DETAILS,
    //         arguments: [lesson,"image"]
    //     );
    //   }
    //
    // }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
